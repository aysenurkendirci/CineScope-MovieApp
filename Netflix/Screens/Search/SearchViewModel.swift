final class SearchViewModel {
    var onResults: (([Movie]) -> Void)?
    var onError: ((Error) -> Void)?

    func search(query: String) {
        guard !query.isEmpty else {
            onResults?([])
            return
        }
        MovieService.shared.searchMovies(query: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.onResults?(movies)
            case .failure(let error):
                self?.onError?(error)
            }
        }
    }
}
