import Foundation
import Alamofire

extension TMDBService {

    func searchMoviesAsync(query: String) async throws -> [Movie] {
        let url = "\(base)/search/movie"
        let params: [String: Any] = [
            "api_key": apiKey,
            "query": query,
            "language": "tr-TR",
            "include_adult": false
        ]
        let resp = try await AF.request(url, parameters: params)
            .serializingDecodable(TMDBListResponse.self).value
        return resp.results
    }

    func similarAsync(movieId: Int) async throws -> [Movie] {
        let url = "\(base)/movie/\(movieId)/similar"
        let params = ["api_key": apiKey, "language": "tr-TR"]
        let resp = try await AF.request(url, parameters: params)
            .serializingDecodable(TMDBListResponse.self).value
        return resp.results
    }

    func trendingAsync() async throws -> [Movie] {
        let url = "\(base)/trending/movie/day"
        let params = ["api_key": apiKey, "language": "tr-TR"]
        let resp = try await AF.request(url, parameters: params)
            .serializingDecodable(TMDBListResponse.self).value
        return resp.results
    }

    func moviesByActorAsync(name: String) async throws -> [Movie] {
        struct PersonSearch: Decodable { struct P: Decodable { let id: Int }; let results: [P] }

        let pURL = "\(base)/search/person"
        let p = try await AF.request(pURL, parameters: [
            "api_key": apiKey, "query": name, "language":"tr-TR"
        ]).serializingDecodable(PersonSearch.self).value
        guard let id = p.results.first?.id else { throw ChatError.notFound(name) }

        let dURL = "\(base)/discover/movie"
        let params: [String: Any] = [
            "api_key": apiKey, "with_cast": id,
            "language":"tr-TR", "include_adult": false, "sort_by":"popularity.desc"
        ]
        let resp = try await AF.request(dURL, parameters: params)
            .serializingDecodable(TMDBListResponse.self).value
        return resp.results
    }
}

enum ChatError: LocalizedError {
    case notFound(String)
    case missingAPIKey(String)

    var errorDescription: String? {
        switch self {
        case .notFound(let what):
            return "\(what) bulunamadı."
        case .missingAPIKey(let keyName):
            return "Eksik/boş API anahtarı: \(keyName)"
        }
    }
}
