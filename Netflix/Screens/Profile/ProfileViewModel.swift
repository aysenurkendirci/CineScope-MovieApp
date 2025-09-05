import Foundation

final class ProfileViewModel {
    var userProfile: UserProfile?
    var favoriteMovies: [MovieCellViewModel] = []

    var onProfileLoaded: (() -> Void)?

    func loadProfile() {
        UserService.shared.fetchUserProfile { [weak self] result in
            switch result {
            case .success(let profile):
                self?.userProfile = profile
                self?.loadFavorites(ids: profile.favorites ?? [])
            case .failure(let error):
                print("Profile load error:", error.localizedDescription)
            }
        }
    }

    private func loadFavorites(ids: [Int]) {
        let group = DispatchGroup()
        var movies: [MovieCellViewModel] = []

        for id in ids {
            group.enter()
            TrailerService.shared.getMovieDetail(id: id) { result in
                if case .success(let detail) = result {
                    movies.append(.init(id: detail.id,
                                        title: detail.title,
                                        posterURL: detail.posterURL,
                                        year: detail.releaseDate))
                }
                group.leave()
            }
        }

        group.notify(queue: .main) { [weak self] in
            self?.favoriteMovies = movies
            self?.onProfileLoaded?()
        }
    }

    func updateAvatar(urlString: String) {
        UserService.shared.updateAvatar(urlString: urlString) { [weak self] result in
            switch result {
            case .success:
                self?.userProfile?.avatarURL = urlString
                self?.onProfileLoaded?()
            case .failure(let e):
                print("Avatar update error:", e.localizedDescription)
            }
        }
    }
}
