/* MoodMapping.swift
import Foundation

enum MoodKind: String {
    case neseli     // 😊 Comedy
    case huzunlu    // 😞 Drama
    case heyecanli  // 🤩 Action
    case gergin     // 😨 Thriller
    case romantik   // 🥰 Romance

    var tmdbGenreId: Int {
        switch self {
        case .neseli:     return 35      // Comedy
        case .huzunlu:    return 18      // Drama
        case .heyecanli:  return 28      // Action
        case .gergin:     return 53      // Thriller
        case .romantik:   return 10749   // Romance
        }
    }
}

extension String {
    /// "Neşeli 😄" -> "neseli", "Hüzünlü" -> "huzunlu" gibi
    func normalizedMoodKey() -> String {
        let s = self
            .lowercased()
            .replacingOccurrences(of: "[^a-zğüşıöç ]",
                                  with: "",
                                  options: .regularExpression)
        if s.contains("neş") || s.contains("nes") { return "neseli" }
        if s.contains("hüz") || s.contains("huz") { return "huzunlu" }
        if s.contains("heyec")                  { return "heyecanli" }
        if s.contains("gerg")                   { return "gergin" }
        if s.contains("roman")                  { return "romantik" }
        return s.trimmingCharacters(in: .whitespaces)
    }
 }*/
