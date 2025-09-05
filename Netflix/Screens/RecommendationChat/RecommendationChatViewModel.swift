import Foundation

// MARK: - Chat Models
enum ChatRole { case user, assistant }

struct ChatMessage {
    let role: ChatRole
    let text: String
}

// MARK: - RecommendationChatViewModel
final class RecommendationChatViewModel {

    // MARK: - Outputs
    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var onOpenTrailer: ((Int) -> Void)?

    private(set) var messages: [ChatMessage] = []
    private(set) var categories: [AgentCategory] = []
    private var isTyping = false

    // Mood seçenekleri kullanıcıya gösterilecek
    private let moodDisplayList = ["Neşeli 😄", "Üzgün 😞", "Korku 😨", "Romantik 🥰", "Heyecanlı 🤩"]

    // Normalize edilmiş key -> MoodPlan
    private var moodPlans: [String: MoodPlan] {
        [
            "neseli": MoodPlan(
                title: "Neşeli / Keyifli",
                replyText: "Neşeli bir ruh hali için hafif ve keyifli filmler buldum. 🎈",
                genreCSV: "35,12", sort: "vote_average.desc"
            ),
            "uzgun": MoodPlan(
                title: "Duygusal / Dram",
                replyText: "Duygusal bir ruh hali için güçlü hikâyeli dram ve romantik filmler öneriyorum. 💫",
                genreCSV: "18,10749", sort: "vote_average.desc"
            ),
            "korku": MoodPlan(
                title: "Korku & Gerilim",
                replyText: "Korku ve gerilim dolu filmlerle seni biraz heyecanlandıralım. 👻",
                genreCSV: "27,53", sort: "vote_average.desc"
            ),
            "romantik": MoodPlan(
                title: "Romantik",
                replyText: "Romantik filmlerden sıcak bir seçki hazırladım. 💞",
                genreCSV: "10749,18", sort: "vote_average.desc"
            ),
            // Normalize edilmiş hali: heyecanli
            "heyecanli": MoodPlan(
                title: "Aksiyon & Macera",
                replyText: "Bol aksiyon ve macera içeren filmler öneriyorum. ⚡️",
                genreCSV: "28,12,878", sort: "vote_average.desc"
            )
        ]
    }

    // MARK: - İlk açılış mesajı
    @MainActor func bootstrapIfNeeded() {
        guard messages.isEmpty else { return }

        messages.append(.init(
            role: .assistant,
            text: "Merhaba! 🎬 Sana film seçerken yardımcı olabilirim."
        ))


        messages.append(.init(
            role: .assistant,
            text: """
✨ Neler yapabilirim:
• Film ara → *Inception*
• IMDb puanına göre listele → *en yüksek imdb*
• Ruh haline göre öneri → *neşeli*, *üzgün*, *korku*, *romantik*, *heyecanlı*
"""
        ))
        onUpdate?()
    }

    // MARK: - Kullanıcı mesajı gönderme
    @MainActor func send(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, isTyping == false else { return }

        messages.append(.init(role: .user, text: trimmed))
        isTyping = true
        onUpdate?()

        Task {
            do {
                let result = try await runLocalPlan(for: trimmed)
                await apply(result)
            } catch {
                await MainActor.run {
                    self.isTyping = false
                    self.messages.append(.init(role: .assistant, text: "Bir hata oluştu. Lütfen tekrar dene."))
                    self.onUpdate?()
                }
            }
        }
    }

    // MARK: - UI Rows
    func uiRows() -> [any CellConfigurator] {
        var rows: [any CellConfigurator] = messages.map {
            MessageCellViewModel(text: $0.text, isUser: $0.role == .user) as any CellConfigurator
        }
        if isTyping {
            rows.append(LoadingCellViewModel() as any CellConfigurator)
        }
        return rows
    }

    // MARK: - Local AgentResult
    private struct AgentResult {
        let assistantText: String
        let categories: [AgentCategory]
        let trailerMovieId: Int?
    }

    private struct MoodPlan {
        let title: String
        let replyText: String
        let genreCSV: String
        let sort: String
    }

    // MARK: - Ana kontrol akışı
    private func runLocalPlan(for text: String) async throws -> AgentResult {
        let lower = normalize(text)

        // IMDb sıralama isteği
        if isIMDBSortRequest(lower) {
            let list = try await TMDBService.shared.discoverAsync(with: [
                "sort_by": "vote_average.desc",
                "vote_count.gte": 200
            ])
            let cats = [AgentCategory(genreId: -11, title: "IMDb: En yüksek puanlılar", movies: list)]
            return AgentResult(
                assistantText: "İşte IMDb puanına göre en yüksek filmler. ⭐️",
                categories: cats,
                trailerMovieId: nil
            )
        }

        // Mood seçimi
        if let plan = strictMoodPlan(for: lower) {
            let list = try await TMDBService.shared.discoverAsync(with: [
                "with_genres": plan.genreCSV,
                "vote_count.gte": 200,
                "sort_by": plan.sort
            ])
            let cats = [AgentCategory(genreId: -3, title: plan.title, movies: list)]
            return AgentResult(
                assistantText: plan.replyText,
                categories: cats,
                trailerMovieId: nil
            )
        }

        // Mood gibi görünüyor ama yanlış yazıldıysa
        if looksLikeMood(lower) {
            let pretty = moodDisplayList.joined(separator: " • ")
            return AgentResult(
                assistantText: "Hmm, sanırım ruh halini paylaştın. 😊 Lütfen aşağıdaki seçeneklerden birini kullan:\n\(pretty)",
                categories: [],
                trailerMovieId: nil
            )
        }

        // Normal film araması
        let list = try await TMDBService.shared.searchMoviesAsync(query: text)
        let cats = [AgentCategory(genreId: -4, title: "Arama: \(text)", movies: list)]
        let msg = list.isEmpty ? "Maalesef sonuç bulamadım. 😔" : "\"\(text)\" için bulduğum sonuçlar:"
        return AgentResult(assistantText: msg, categories: cats, trailerMovieId: nil)
    }

    // MARK: - Apply
    @MainActor private func apply(_ r: AgentResult) {
        self.isTyping = false
        self.messages.append(.init(role: .assistant, text: r.assistantText))
        self.categories = r.categories
        if let id = r.trailerMovieId { self.onOpenTrailer?(id) }
        self.onUpdate?()
    }

    // MARK: - Mood Logic
    private func strictMoodPlan(for lower: String) -> MoodPlan? {
        return moodPlans[lower]
    }

    private func looksLikeMood(_ s: String) -> Bool {
        containsAny(s, ["mod", "hissediyorum", "mutlu", "neseli", "uzgun", "kotu", "korku", "romantik", "heyecan"])
    }

    // MARK: - Utilities
    private func normalize(_ s: String) -> String {
        s.folding(options: .diacriticInsensitive, locale: .current)
         .lowercased()
         .trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func containsAny(_ s: String, _ keys: [String]) -> Bool {
        keys.contains { s.contains($0) }
    }

    private func isIMDBSortRequest(_ s: String) -> Bool {
        containsAny(s, ["imdb", "puan", "en yuksek", "en yüksek"])
    }
}
