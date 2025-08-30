struct CreditsResponse: Decodable {
    let cast: [Cast]
}

struct Cast: Decodable {
    let id: Int
    let name: String
    let profile_path: String?
    
    var profileURL: String? {
        guard let path = profile_path else { return nil }
        return "https://image.tmdb.org/t/p/w200\(path)"
    }
}
