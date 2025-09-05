import Foundation

enum ChatRole { case user, assistant }

struct ChatMessage {
    let role: ChatRole
    let text: String
}

final class RecommendationChatViewModel {

    var onUpdate: (() -> Void)?
    var onError: ((String) -> Void)?
    var onOpenTrailer: ((Int) -> Void)?

    private(set) var messages: [ChatMessage] = []
    private(set) var categories: [AgentCategory] = []
    private var isTyping = false

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
• Oyuncuya göre ara → *Brad Pitt filmleri*
"""
        ))
        onUpdate?()
    }
    
    @MainActor func send(_ text: String) {
        let trimmed = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, isTyping == false else { return }

        messages.append(.init(role: .user, text: trimmed))
        isTyping = true
        onUpdate?()

        let allMessagesForAPI = messages

        Task { [weak self] in
            try? await Task.sleep(nanoseconds: 40 * 1_000_000_000)
            guard let self, self.isTyping else { return }
            self.isTyping = false
            self.messages.append(.init(role: .assistant, text: "Zaman aşımı. Tekrar dener misin?"))
            self.onUpdate?()
        }

        Task {
            do {
                let result = try await OpenAIService.shared.reply(userText: trimmed, history: allMessagesForAPI)
                await apply(result)
            } catch {
                await MainActor.run {
                    self.isTyping = false
                    self.messages.append(.init(role: .assistant, text: error.localizedDescription))
                    self.onUpdate?()
                }
            }
        }
    }

    func uiRows() -> [any CellConfigurator] {
        var rows: [any CellConfigurator] = messages.map {
            MessageCellViewModel(text: $0.text, isUser: $0.role == .user) as any CellConfigurator
        }
        if isTyping {
            rows.append(LoadingCellViewModel() as any CellConfigurator)
        }
        return rows
    }
    
    @MainActor private func apply(_ r: AgentResult) {
        self.isTyping = false
        self.messages.append(.init(role: .assistant, text: r.assistantText))
        self.categories = r.categories
        if let id = r.trailerMovieId { self.onOpenTrailer?(id) }
        self.onUpdate?()
    }
}
