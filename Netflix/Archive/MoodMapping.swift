/*import Foundation

extension String {
    func normalizedMoodKey() -> String {
        let s = self.lowercased()
            .replacingOccurrences(of: "[^a-zğüşıöç ]", with: "", options: .regularExpression)
        if s.contains("neş") || s.contains("nes") { return "neseli" }
        if s.contains("hüz") || s.contains("huz") { return "huzunlu" }
        if s.contains("heyec")                  { return "heyecanli" }
        if s.contains("gerg")                   { return "gergin" }
        if s.contains("roman")                  { return "romantik" }
        return s.trimmingCharacters(in: .whitespaces)
    }
}
