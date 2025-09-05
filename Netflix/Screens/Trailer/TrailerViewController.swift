import UIKit
import Foundation
import SnapKit

final class TrailerViewController: BaseCollectionViewController {
    
    private let viewModel = TrailerViewModel()
    let movieId: Int?
    var isFavorite: Bool = false
    
    init(movieId: Int? = nil) {
        self.movieId = movieId
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private var headerSection = Section()
    private var ratingSection = Section()
    private var castSection = Section()
    private var videoSection = Section()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieId = movieId {
            setupFavoriteButton()
            fetchData(movieId: movieId)
        } else {
            showEmptyState()
        }
    }
  
    func fetchData(movieId: Int) {
        viewModel.fetchMovieDetail(movieId: movieId) { [weak self] in
            self?.buildUI()
        }
        
        UserService.shared.isFavorite(movieId: movieId) { [weak self] result in
            switch result {
            case .success(let fav):
                self?.isFavorite = fav
                self?.updateFavoriteIcon()
            case .failure(let error):
                print("Favori kontrol hatası:", error.localizedDescription)
            }
        }
    }

    private func buildUI() {
        collectionSections = []
        
        headerSection = Section(layoutType: .vertical, rows: [])
        ratingSection = Section(layoutType: .vertical, rows: [])
        castSection = Section(layoutType: .horizontal, rows: [])
        videoSection = Section(layoutType: .vertical, rows: [])
        
        addHeader()
        addRating()
        addCast()
        addTrailer()
        
        collectionSections = [headerSection, ratingSection, castSection, videoSection]
        baseView.collectionView.reloadData()
    }

    private func addHeader() {
        let vm = TrailerHeaderViewModel(
            posterURL: viewModel.posterURL,
            title: viewModel.title,
            overview: viewModel.overview
        )
        headerSection.rows.append(vm)
    }
    
    private func addRating() {
        let vm = TrailerRatingViewModel(
            average: viewModel.rating,
            totalReviews: viewModel.totalReviews,
            breakdown: viewModel.ratingBreakdown
        )
        ratingSection.rows.append(vm)
    }
    
    private func addCast() {
        let vm = TrailerCastViewModel(cast: viewModel.cast)
        castSection.rows.append(vm)
    }
    
    private func addTrailer() {
        let vm = TrailerVideoViewModel(trailerURL: viewModel.trailerURL)
        videoSection.rows.append(vm)
    }
    
    override func registerCells() {
        register([
            TrailerHeaderCell.self,
            TrailerRatingCell.self,
            TrailerCastCell.self,
            TrailerVideoCell.self,
            CastItemCell.self
        ])
    }
}
