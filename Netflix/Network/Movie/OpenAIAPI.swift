import Foundation
import Moya

enum OpenAIAPI {
    case classify(apiKey: String, text: String, locale: String)
    case chat(apiKey: String, payload: [String: Any])
}

extension OpenAIAPI: TargetType {
    var baseURL: URL { URL(string: "https://api.openai.com/v1")! }
    var path: String { "/chat/completions" }
    var method: Moya.Method { .post }

    
    var validationType: ValidationType { .none }

    var task: Task {
        switch self {
        case .classify(_, let text, let locale):
            
            let body: [String: Any] = [
                "model": RC.shared.model,
                "temperature": 0.1,
                "response_format": ["type": "json_object"],
                "messages": [
                    ["role":"system","content":
                        """
                        You are a tagger. Output ONLY valid JSON with keys:
                        - genres: array of strings from {comedy, action, romance, drama, thriller, horror, scifi, animation}
                        - rating: one of {low, mid, high} (optional)
                        - runtime: one of {short, medium, long} (optional)
                        No extra text. No film names.
                        """
                    ],
                    ["role":"user","content":"Text: \(text)\nLocale: \(locale)"]
                ]
            ]
            return .requestParameters(parameters: body, encoding: JSONEncoding.default)

        case .chat(_, let payload):
            return .requestParameters(parameters: payload, encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
        case .classify(let key, _, _), .chat(let key, _):
            return [
                "Authorization": "Bearer \(key)",
                "Content-Type": "application/json"
            ]
        }
    }

    var sampleData: Data { Data() }
}
