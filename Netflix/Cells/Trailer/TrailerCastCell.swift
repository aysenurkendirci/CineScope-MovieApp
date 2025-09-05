import UIKit
import SnapKit

struct TrailerCastViewModel: CellConfigurator {
    static var reuseId: String { String(describing: TrailerCastCell.self) }

    let cast: [Cast]

    func configure(cell: UICollectionViewCell) {
        (cell as? TrailerCastCell)?.configure(with: self)
    }
}

final class TrailerCastCell: UICollectionViewCell,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    private let titleLabel = UILabel()
    private let collectionView: UICollectionView
    private var cast: [Cast] = []
    
    override init(frame: CGRect) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        titleLabel.text = "Oyuncular"
        titleLabel.font = .boldSystemFont(ofSize: 20)
        titleLabel.textColor = .white
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(CastItemCell.self, forCellWithReuseIdentifier: "CastItemCell")
        
        let stack = UIStackView(arrangedSubviews: [titleLabel, collectionView])
        stack.axis = .vertical
        stack.spacing = 12
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(160) // sabit yükseklik
        }
    }
    
    func configure(with vm: TrailerCastViewModel) {
        self.cast = vm.cast
        collectionView.reloadData()
    }
    
    // MARK: - DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CastItemCell", for: indexPath) as! CastItemCell
        cell.configure(with: cast[indexPath.row])
        return cell
    }
    
    // MARK: - Layout
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let visibleItems: CGFloat = 3 // aynı anda 3 oyuncu görünsün
        let spacing: CGFloat = 12
        let totalSpacing = (visibleItems - 1) * spacing
        let availableWidth = collectionView.bounds.width - totalSpacing
        let cellWidth = floor(availableWidth / visibleItems)
        
        return CGSize(width: cellWidth, height: 150)
    }
}
final class CastItemCell: UICollectionViewCell {
    
    private let imageView = UIImageView()
    private let nameLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .darkGray
        contentView.addSubview(imageView)
        
        nameLabel.font = .systemFont(ofSize: 14, weight: .medium)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .center
        nameLabel.numberOfLines = 2
        nameLabel.adjustsFontSizeToFitWidth = true
        nameLabel.minimumScaleFactor = 0.7
        contentView.addSubview(nameLabel)
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.left.right.equalToSuperview().inset(4)
            make.height.equalTo(36)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    func configure(with cast: Cast) {
        nameLabel.text = cast.name
        
        if let urlString = cast.profileURL, let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
                if let data = data, let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.imageView.image = image
                    }
                }
            }.resume()
        } else {
            imageView.image = UIImage(systemName: "person.circle.fill")
            imageView.tintColor = .gray
        }
    }
}
