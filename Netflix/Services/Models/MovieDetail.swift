struct MovieDetail: Decodable {
    let id: Int
    let title: String
    let overview: String
    let poster_path: String?
    let vote_average: Double
    let vote_count: Int
    
    var posterURL: String? {
        guard let path = poster_path else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
    }
}
