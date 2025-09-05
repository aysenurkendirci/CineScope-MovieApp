import UIKit

final class SearchViewController: BaseCollectionViewController {
    
    private let viewModel = SearchViewModel()
    
    private var headerSection = Section(layoutType: .vertical, rows: [])
    private var resultsSection = Section(layoutType: .grid2, rows: [])
    private var currentMovies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupRecommendationButton()
        buildUI()
    }
    private func setupRecommendationButton() {
            let recommendationButton = UIBarButtonItem(
                image: UIImage(systemName: "lightbulb.fill"),
                style: .plain,
                target: self,
                action: #selector(didTapRecommendation)
            )
            recommendationButton.tintColor = .white
            navigationItem.rightBarButtonItem = recommendationButton
        }
        @objc private func didTapRecommendation() {
            let recommendationVC = RecommendationChatViewController()
            navigationController?.pushViewController(recommendationVC, animated: true)
        }
    
    private func setupBindings() {
        viewModel.onResults = { [weak self] movies in
            guard let self else { return }
        self.currentMovies = movies
            self.buildUI()
        }
        viewModel.onError = { error in
            print("Search error:", error)
        }
    }
    private func buildUI() {
    
        if headerSection.rows.isEmpty {
            headerSection.rows = [SearchHeaderViewModel(delegate: self)]
        }

        resultsSection.rows = currentMovies.map {
            MovieCellViewModel(id: $0.id,
                               title: $0.title,
                               posterURL: $0.posterURL,
                               year: $0.release_date)
        }
        collectionSections = [headerSection, resultsSection]

        if collectionView.numberOfSections > 1 {
            collectionView.reloadSections(IndexSet(integer: 1))
        } else {
            collectionView.reloadData()
        }
    }
    
    override func registerCells() {
        register([
            SearchHeaderCell.self,
            MovieCell.self
        ])
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(query: searchText)
    }
}
