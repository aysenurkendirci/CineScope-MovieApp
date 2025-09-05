import Foundation
import Moya

struct AgentCategory { let genreId: Int?; let title: String; let movies: [Movie] }

struct AgentResult {
    let assistantText: String
    let categories: [AgentCategory]
    let trailerMovieId: Int?
}

final class OpenAIService {
    static let shared = OpenAIService()
    private init() {}

    private let provider = OpenAIService.makeProvider()

    private static func makeProvider() -> MoyaProvider<OpenAIAPI> {
        let session = MoyaProvider<OpenAIAPI>.defaultAlamofireSession()
        session.sessionConfiguration.timeoutIntervalForRequest = 30
        session.sessionConfiguration.timeoutIntervalForResource = 60

        let logger = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
        let rawLogger = PluginTypeWrapper { result in
            switch result {
            case .success(let resp):
                let body = String(data: resp.data, encoding: .utf8) ?? "(no body)"
                print(" OpenAI RAW RESPONSE [\(resp.statusCode)]:\n\(body)")
            case .failure(let err):
                print(" OpenAI FAILURE: \(err)")
            }
        }
        return MoyaProvider<OpenAIAPI>(session: session, plugins: [logger, rawLogger])
    }

    private struct PluginTypeWrapper: PluginType {
        let onResponse: (Result<Response, MoyaError>) -> Void
        init(_ onResponse: @escaping (Result<Response, MoyaError>) -> Void) { self.onResponse = onResponse }
        func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
            onResponse(result)
        }
    }

    private let systemPromptTR: String = """
    Sen bir Film Asistanısın ve aynı zamanda bir sohbet arkadaşısın. Kullanıcının Türkçe yazdığı istekleri anla ve aşağıdaki FONKSİYONLARI (tools) gerektiğinde çağır. Eğer bir film veya duyguyla ilgili olmayan bir şey sorarsa, kısa ve samimi bir metinle yanıt ver.

    Hangi durumda hangi tool'u kullanacağını kendin seçebilirsin.
    - search_movies(query): serbest metin arama
    - similar_movies(title): verilen film adına benzerler
    - movies_by_actor(name): oyuncu filmografisi
    - trending_movies(): günün trendleri
    - open_trailer(title): fragman aç (UI tetiklenecek)
    - discover_by_mood(mood): ruh haline göre keşif (TR)
    - search_by_rating(order): IMDb puanına göre sırala
    - search_by_genre(genre): türe göre film listele

    Yanıt üretirken:
    - Türkçe konuş.
    - Tool sonuçları geldikten sonra kısa ve anlaşılır bir özet yaz.
    - Kullanıcıya, neşeli, coşkulu, sakin veya düşünceli bir tonda yaklaş.
    """

    func reply(userText: String, history: [ChatMessage]) async throws -> AgentResult {
        try await RC.shared.ensureLoaded()
        let key = RC.shared.openAIKey.trimmingCharacters(in: .whitespacesAndNewlines)
        let model = RC.shared.model.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !key.isEmpty else {
            throw NSError(domain: "OpenAI", code: 401,
                          userInfo: [NSLocalizedDescriptionKey: "OpenAI anahtarı boş. Firebase Remote Config → openai_api_key değerini girin."])
        }
        guard !model.isEmpty else {
            throw NSError(domain: "OpenAI", code: 400,
                          userInfo: [NSLocalizedDescriptionKey: "Model boş. Firebase Remote Config → rec_model değerini (ör. gpt-4o-mini) ayarlayın."])
        }

        var messages: [[String: Any]] = [
            ["role": "system", "content": systemPromptTR]
        ]
        for m in history {
            messages.append([
                "role": (m.role == .user ? "user" : "assistant"),
                "content": m.text
            ])
        }
        messages.append(["role": "user", "content": userText])

        let tools = buildToolsSchema()

        let firstResponse = try await sendChat(key: key, model: model, messages: messages, tools: tools)
        let firstMsg = firstResponse.choices.first?.message
        let calls = firstMsg?.tool_calls ?? []

        if let firstMsg = firstMsg {
            var assistantDict: [String: Any] = [
                "role": "assistant",
                "content": firstMsg.content ?? ""
            ]
            if !calls.isEmpty {
                assistantDict["tool_calls"] = calls.map { call in
                    [
                        "id": call.id,
                        "type": call.type,
                        "function": [
                            "name": call.function.name,
                            "arguments": call.function.arguments
                        ]
                    ]
                }
            }
            messages.append(assistantDict)
        }

        var collectedCategories: [AgentCategory] = []
        var collectedTrailerId: Int? = nil

        if !calls.isEmpty {
            for call in calls {
                let toolJSON = try await runTool(call: call,
                                                 collect: &collectedCategories,
                                                 trailerId: &collectedTrailerId)
                messages.append([
                    "role": "tool",
                    "tool_call_id": call.id,
                    "content": toolJSON
                ])
            }
            let finalResponse = try await sendChat(key: key, model: model, messages: messages, tools: tools)
            let text = finalResponse.choices.first?.message.content ?? "Hazır."
            return AgentResult(assistantText: text,
                               categories: collectedCategories,
                               trailerMovieId: collectedTrailerId)
        } else {
            let text = (firstMsg?.content?.isEmpty == false) ? (firstMsg!.content!) : "Hazır."
            return AgentResult(assistantText: text, categories: [], trailerMovieId: nil)
        }
    }
    private func runTool(call: ToolCall,
                         collect categories: inout [AgentCategory],
                         trailerId: inout Int?) async throws -> String {

        let name = call.function.name
        let argsStr = call.function.arguments
        let argsData = argsStr.data(using: .utf8) ?? Data()
        let args = (try? JSONSerialization.jsonObject(with: argsData)) as? [String: Any] ?? [:]

        switch name {
        case "search_movies":
            let query = (args["query"] as? String ?? "").trimmingCharacters(in: .whitespaces)
            let list = try await TMDBService.shared.searchMoviesAsync(query: query)
            categories.append(.init(genreId: nil, title: "Arama: \(query)", movies: list))
            let payload = ["results": list.prefix(20).map { ["id": $0.id, "title": $0.title, "year": $0.release_date ?? ""] }]
            return toJSONString(payload)

        case "similar_movies":
            let title = (args["title"] as? String ?? "").trimmingCharacters(in: .whitespaces)
            let id = try await findMovieIdByTitle(title)
            let sim = try await TMDBService.shared.similarAsync(movieId: id)
            categories.append(.init(genreId: nil, title: "“\(title)” benzerleri", movies: sim))
            let payload: [String: Any] = ["base_id": id, "results": sim.prefix(20).map { ["id": $0.id, "title": $0.title] }]
            return toJSONString(payload)

        case "movies_by_actor":
            let name = (args["name"] as? String ?? "").trimmingCharacters(in: .whitespaces)
            guard !name.isEmpty else {
                return toJSONString(["error": "could not find a valid actor name in the query."])
            }
            let list = try await TMDBService.shared.moviesByActorAsync(name: name)
            categories.append(.init(genreId: nil, title: "\(name) filmleri", movies: list))
            let payload: [String: Any] = ["actor": name, "results": list.prefix(20).map { ["id": $0.id, "title": $0.title] }]
            return toJSONString(payload)

        case "trending_movies":
            let list = try await TMDBService.shared.trendingAsync()
            categories.append(.init(genreId: nil, title: "Bugünün trendleri", movies: list))
            let payload = ["results": list.prefix(20).map { ["id": $0.id, "title": $0.title] }]
            return toJSONString(payload)

        case "open_trailer":
            let title = (args["title"] as? String ?? "").trimmingCharacters(in: .whitespaces)
            let id = try await findMovieIdByTitle(title)
            trailerId = id
            return toJSONString(["opened_trailer_for": title, "movie_id": id])

        default:
            return toJSONString(["error": "unknown_tool"])
        }
    }

    private func sendChat(key: String,
                          model: String,
                          messages: [[String:Any]],
                          tools: [[String:Any]]) async throws -> ChatResp {

        var payload: [String: Any] = [
            "model": model,
            "temperature": 0.2,
            "messages": messages
        ]
        if !tools.isEmpty {
            payload["tools"] = tools
            payload["tool_choice"] = "auto"
        }

        return try await withCheckedThrowingContinuation { cont in
            provider.request(.chat(apiKey: key, payload: payload)) { result in
                switch result {
                case .success(let response):
                    if !(200..<300).contains(response.statusCode) {
                        let body = String(data: response.data, encoding: .utf8) ?? "(no body)"
                        if let msg = (try? JSONSerialization.jsonObject(with: response.data)) as? [String:Any],
                           let err = (msg["error"] as? [String:Any])?["message"] as? String {
                            cont.resume(throwing: NSError(domain: "OpenAI", code: response.statusCode,
                                userInfo: [NSLocalizedDescriptionKey: "HTTP \(response.statusCode): \(err)"]))
                        } else {
                            cont.resume(throwing: NSError(domain: "OpenAI", code: response.statusCode,
                                userInfo: [NSLocalizedDescriptionKey: "HTTP \(response.statusCode): \(body)"]))
                        }
                        return
                    }
                    do {
                        let chatResponse = try response.map(ChatResp.self)
                        cont.resume(returning: chatResponse)
                    } catch {
                        cont.resume(throwing: error)
                    }
                case .failure(let error):
                    cont.resume(throwing: error)
                }
            }
        }
    }
    private func buildToolsSchema() -> [[String: Any]] {
        func fn(_ name: String, _ desc: String, _ props: [String: Any], required: [String]) -> [String: Any] {
            ["type":"function",
             "function":[
                 "name": name,
                 "description": desc,
                 "parameters":[
                     "type":"object",
                     "properties": props,
                     "required": required
                 ]
             ]]
        }
        return [
            fn("search_movies", "Serbest metinle film ara (TR).",
               ["query":["type":"string","description":"Film adı veya arama metni"]],
               required: ["query"]),
            fn("similar_movies", "Verilen filme benzerleri getir.",
               ["title":["type":"string"]], required: ["title"]),
            fn("movies_by_actor", "Belirli oyuncunun filmleri.",
               ["name":["type":"string"]], required: ["name"]),
            fn("trending_movies", "Günün trend filmleri.", [:], required: [])
        ]
    }

    private func findMovieIdByTitle(_ title: String) async throws -> Int {
        let list = try await TMDBService.shared.searchMoviesAsync(query: title)
        guard let id = list.first?.id else {
            throw NSError(domain: "agent", code: 404,
                          userInfo: [NSLocalizedDescriptionKey:"Film bulunamadı"])
        }
        return id
    }

    private func toJSONString(_ obj: Any) -> String {
        guard JSONSerialization.isValidJSONObject(obj),
              let d = try? JSONSerialization.data(withJSONObject: obj, options: []),
              let s = String(data: d, encoding: .utf8) else { return "{}" }
        return s
    }
}

// MARK: - Response Models
struct ChatResp: Decodable {
    struct Choice: Decodable {
        struct Message: Decodable {
            let content: String?
            let tool_calls: [ToolCall]?
        }
        let message: Message
        let finish_reason: String?
    }
    let choices: [Choice]
}

struct ToolCall: Decodable {
    struct Fn: Decodable { let name: String; let arguments: String }
    let id: String
    let type: String
    let function: Fn
}
