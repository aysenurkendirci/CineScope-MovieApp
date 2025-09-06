/*import Foundation
import Alamofire

// Cevap modeli
struct TMDBListResponse: Decodable { let results: [Movie] }

final class TMDBService {
    static let shared = TMDBService(); private init() {}
    private let base = "https://api.themoviedb.org/3"
    private var apiKey: String { RC.shared.tmdbKey }

    // Callback'li sürüm
    func discover(with params: [String: Any],
                  completion: @escaping (Result<[Movie], Error>) -> Void) {
        var q = params
        if q["api_key"] == nil { q["api_key"] = apiKey }

        AF.request("\(base)/discover/movie",
                   method: .get,
                   parameters: q,
                   encoding: URLEncoding.default)
        .validate()
        .responseDecodable(of: TMDBListResponse.self) { resp in
            switch resp.result {
            case .success(let list): completion(.success(list.results))
            case .failure(let e):    completion(.failure(e))
            }
        }
    }

    // ✅ Async/await sürümü — sınıfın içinde (extension DEĞİL)
    func discoverAsync(with params: [String: Any]) async throws -> [Movie] {
        try await withCheckedThrowingContinuation { cont in
            self.discover(with: params) { (result: Result<[Movie], Error>) in
                switch result {
                case .success(let movies): cont.resume(returning: movies)
                case .failure(let err):    cont.resume(throwing: err)
                }
            }
        }
    }
 }*/
