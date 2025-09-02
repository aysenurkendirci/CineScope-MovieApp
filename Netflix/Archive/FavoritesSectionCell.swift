import UIKit
import SnapKit

struct FavoritesSectionViewModel {
    let movies: [FavoriteCellViewModel]
}

final class FavoritesSectionCell: UICollectionViewCell,
                                  UICollectionViewDataSource,
                                  UICollectionViewDelegateFlowLayout {
    
    private var favorites: [FavoriteCellViewModel] = []
    private var collectionView: UICollectionView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 12
        layout.minimumLineSpacing = 16
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(
            FavoriteCell.self,
            forCellWithReuseIdentifier: String(describing: FavoriteCell.self)
        )
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    
    func configure(with favorites: [FavoriteCellViewModel]) {
        self.favorites = favorites
        collectionView.reloadData()
        layoutIfNeeded()
    }
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        favorites.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: FavoriteCell.self),
            for: indexPath
        ) as! FavoriteCell
        cell.configure(with: favorites[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 12
        let screenWidth = UIScreen.main.bounds.width
        let availableWidth = screenWidth - (padding * 3)
        let width = availableWidth / 2
        
        let posterHeight = width * 1.5
        let labelHeight: CGFloat = 40    
        return CGSize(width: width, height: posterHeight + labelHeight)
    }

    // MARK: - Dynamic Height
    override func systemLayoutSizeFitting(_ targetSize: CGSize) -> CGSize {
        collectionView.layoutIfNeeded()
        let height = collectionView.collectionViewLayout.collectionViewContentSize.height
        return CGSize(width: targetSize.width, height: height)
    }
}
