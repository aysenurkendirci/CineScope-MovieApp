struct Movie: Decodable {
    let id: Int
    let title: String
    let poster_path: String?
    let release_date: String?
    let voteAverage: Double? 

    var year: String { release_date?.prefix(4).description ?? "-" }

    var posterURL: String? {
        guard let path = poster_path else { return nil }
        return "https://image.tmdb.org/t/p/w500\(path)"
    }

    enum CodingKeys: String, CodingKey {
        case id, title
        case poster_path = "poster_path"
        case release_date = "release_date"
        case voteAverage = "vote_average"
    }
}
