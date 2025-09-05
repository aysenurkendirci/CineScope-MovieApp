import UIKit
import SnapKit

struct MovieSectionViewModel: CellConfigurator {
    static var reuseId: String { String(describing: MovieSectionCell.self) }

    let title: String
    let movies: [Movie]

    func configure(cell: UICollectionViewCell) {
        (cell as? MovieSectionCell)?.configure(with: self)
    }
}

protocol MovieSectionCellDelegate: AnyObject {
    func didSelectMovie(_ movie: Movie)
}

final class MovieSectionCell: UICollectionViewCell,
                              UICollectionViewDataSource,
                              UICollectionViewDelegateFlowLayout {
    
    weak var delegate: MovieSectionCellDelegate?
    
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    private var movies: [Movie] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        titleLabel.font = .boldSystemFont(ofSize: 18)
        titleLabel.textColor = .white
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: "MovieCell")
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
        stack.axis = .vertical
        stack.spacing = 8
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(250)
        }
    }
    
    func configure(with vm: MovieSectionViewModel) {
        titleLabel.text = vm.title
        self.movies = vm.movies
        collectionView.reloadData()
    }
    
    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MovieCell",
            for: indexPath
        ) as! MovieCell
        
        let movie = movies[indexPath.row]
        let vm = MovieCellViewModel(
            id: movie.id,
            title: movie.title,
            posterURL: movie.posterURL,
            year: movie.release_date
        )
        cell.configure(with: vm)
        return cell
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: 140, height: 220)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        delegate?.didSelectMovie(movie)
    }
}
