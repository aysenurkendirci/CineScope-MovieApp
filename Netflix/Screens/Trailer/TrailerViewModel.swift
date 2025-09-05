import Foundation
///state
final class TrailerViewModel {
    var posterURL: String = ""
    var title: String = ""
    var overview: String = ""
    var rating: Double = 0.0
    var totalReviews: Int = 0
    var ratingBreakdown: [Int: Int] = [:]
    var cast: [Cast] = []
    var trailerURL: String = ""

    func fetchMovieDetail(movieId: Int, completion: @escaping () -> Void) { ///DispatchGroup ile 3 farklı servisi aynanda kullanabiliyorum
        let group = DispatchGroup()
        ///completion  networkten sonra
        ///
        ///decode işlemleri
        group.enter()
        NetworkProvider.shared.request(.detail(movieId: movieId)) { [weak self] result in
            if case .success(let response) = result {
                do {
                    let detail = try JSONDecoder().decode(MovieDetail.self, from: response.data)
                    self?.posterURL = detail.posterURL ?? ""
                    self?.title = detail.title
                    self?.overview = detail.overview
                    self?.rating = detail.voteAverage
                    self?.totalReviews = detail.voteCount
                } catch {
                    print("Decode error (detail):", error)
                }
            }
            group.leave()
        }
        
        group.enter()
        NetworkProvider.shared.request(.credits(movieId: movieId)) { [weak self] result in
            if case .success(let response) = result {
                do {
                    let credits = try JSONDecoder().decode(CreditsResponse.self, from: response.data)
                    self?.cast = credits.cast
                } catch {
                    print("Decode error (credits):", error)
                }
            }
            group.leave()
        }
        group.enter()
        NetworkProvider.shared.request(.videos(movieId: movieId)) { [weak self] result in
            if case .success(let response) = result {
                do {
                    let videos = try JSONDecoder().decode(VideoResponse.self, from: response.data)
                    if let trailer = videos.results.first(where: { $0.type == "Trailer" }) {
                        self?.trailerURL = "https://www.youtube.com/watch?v=\(trailer.key)"
                    }
                } catch {
                    print("Decode error (videos):", error)
                }
            }
            group.leave()
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}
