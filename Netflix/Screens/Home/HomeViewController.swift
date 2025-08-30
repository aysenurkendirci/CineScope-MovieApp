import UIKit

final class HomeViewController: BaseCollectionViewController {
    
    private let viewModel = HomeViewModel()
    
    private var popularSection = Section()
    private var nowPlayingSection = Section()
    private var upcomingSection = Section()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
        fetchData()
    }
    
    private func buildUI() {
        collectionSections = []
        
        popularSection.rows = []
        nowPlayingSection.rows = []
        upcomingSection.rows = []
        
        addPopularMovies()
        addNowPlayingMovies()
        addUpcomingMovies()
        
        collectionSections = [popularSection, nowPlayingSection, upcomingSection]
        collectionView.reloadData()
    }
    
    private func addPopularMovies() {
        let vm = MovieSectionViewModel(title: "Popüler Filmler", movies: viewModel.popularMovies)
        popularSection.rows?.append(vm)
    }
    
    private func addNowPlayingMovies() {
        let vm = MovieSectionViewModel(title: "Vizyondakiler", movies: viewModel.nowPlayingMovies)
        nowPlayingSection.rows?.append(vm)
    }

    private func addUpcomingMovies() {
        let vm = MovieSectionViewModel(title: "Yakında", movies: viewModel.upcomingMovies)
        upcomingSection.rows?.append(vm)
    }
    
    private func fetchData() {
        viewModel.fetchMovies { [weak self] in
            self?.buildUI()
        }
    }
    
    override func registerCells() {
        register([
            MovieCell.self,
            MovieSectionCell.self
        ])
    }
    
    // ✅ Cell oluştururken delegate’i bağla
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section = collectionSections[indexPath.section]
        if let vm = section.rows?[indexPath.row] as? MovieSectionViewModel {
            let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: MovieSectionCell.self),
                for: indexPath
            ) as! MovieSectionCell
            cell.configure(with: vm)
            cell.delegate = self
            return cell
        }
        return super.collectionView(collectionView, cellForItemAt: indexPath)
    }
}

// MARK: - Delegate Implementation
extension HomeViewController: MovieSectionCellDelegate {
    func didSelectMovie(_ movie: Movie) {
        let trailerVC = TrailerViewController(movieId: movie.id)
        navigationController?.pushViewController(trailerVC, animated: true)
    }
}

