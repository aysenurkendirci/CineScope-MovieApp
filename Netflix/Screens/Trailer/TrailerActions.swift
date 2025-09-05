import UIKit

extension TrailerViewController {
    
    func showEmptyState() {
        let emptyView = TrailerEmptyStateView()
        
        emptyView.onBrowseTapped = { [weak self] in
            self?.tabBarController?.selectedIndex = 0
        }
        emptyView.onDailyTapped = { [weak self] in
            self?.presentDailyMovieSheet()
        }
        view.addSubview(emptyView)
        emptyView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func presentDailyMovieSheet() {
        MovieService.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                guard let randomMovie = movies.randomElement() else { return }
                
                DispatchQueue.main.async {
                    let trailerVC = TrailerViewController(movieId: randomMovie.id)
                    trailerVC.title = "🎬 Günün Filmi"
                    let nav = UINavigationController(rootViewController: trailerVC)
                    
                    if #available(iOS 15.0, *) {
                        if let sheet = nav.sheetPresentationController {
                            sheet.detents = [.medium(), .large()]
                            sheet.prefersGrabberVisible = true
                        }
                    }
                    
                    self?.present(nav, animated: true)
                }
                
            case .failure(let error):
                print("Film alınamadı: \(error.localizedDescription)")
            }
        }
    }
    
    func setupFavoriteButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "heart"),
            style: .plain,
            target: self,
            action: #selector(didTapFavorite)
        )
        navigationItem.rightBarButtonItem?.tintColor = .systemRed
    }
    
    func updateFavoriteIcon() {
        navigationItem.rightBarButtonItem?.image = UIImage(
            systemName: isFavorite ? "heart.fill" : "heart"
        )
    }
    
    @objc func didTapFavorite() {
        guard let movieId = movieId else {
            print("Favori işlemi iptal edildi: movieId yok (boş state).")
            return
        }
        
        if isFavorite {
            UserService.shared.removeFavorite(movieId: movieId) { [weak self] result in
                switch result {
                case .success:
                    self?.isFavorite = false
                    self?.updateFavoriteIcon()
                    NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
                case .failure(let error):
                    print("Fav kaldırma sorun:", error.localizedDescription)
                }
            }
        } else {
            UserService.shared.addFavorite(movieId: movieId) { [weak self] result in
                switch result {
                case .success:
                    self?.isFavorite = true
                    self?.updateFavoriteIcon()
                    NotificationCenter.default.post(name: .favoritesUpdated, object: nil)
                case .failure(let error):
                    print("Favori ekleme hatası:", error.localizedDescription)
                }
            }
        }
    }
}
