import Foundation

final class TrailerService {
    static let shared = TrailerService()
    private init() {}
    
    func getMovieDetail(id: Int, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        NetworkProvider.shared.request(.detail(movieId: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(MovieDetail.self, from: response.data)
                    completion(.success(decoded))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieCredits(id: Int, completion: @escaping (Result<[Cast], Error>) -> Void) {
        NetworkProvider.shared.request(.credits(movieId: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(CreditsResponse.self, from: response.data)
                    completion(.success(decoded.cast))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getMovieVideos(id: Int, completion: @escaping (Result<[Video], Error>) -> Void) {
        NetworkProvider.shared.request(.videos(movieId: id)) { result in
            switch result {
            case .success(let response):
                do {
                    let decoded = try JSONDecoder().decode(VideoResponse.self, from: response.data)
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
