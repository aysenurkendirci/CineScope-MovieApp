import Foundation

final class MovieService {
    static let shared = MovieService()
    
    private init() {}
    
    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        NetworkProvider.shared.request(.popular) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getNowPlayingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        NetworkProvider.shared.request(.nowPlaying) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getUpcomingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        NetworkProvider.shared.request(.upcoming) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieResponse.self, from: response.data)
                    completion(.success(decoded.results))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
