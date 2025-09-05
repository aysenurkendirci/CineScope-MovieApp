import UIKit
import SnapKit
import SDWebImage

struct MovieCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: MovieCell.self) }

    let id: Int
    let title: String
    let posterURL: String?
    let year: String?

    func configure(cell: UICollectionViewCell) {
        (cell as? MovieCell)?.configure(with: self)
    }
}

final class MovieCell: UICollectionViewCell {
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    private func setupUI() {
        posterImageView.layer.cornerRadius = 8
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(4)
            make.leading.trailing.bottom.equalToSuperview().inset(4)
        }
    }
    
    func configure(with vm: MovieCellViewModel) {
        titleLabel.text = vm.title
        if let urlStr = vm.posterURL, let url = URL(string: urlStr) {
            posterImageView.sd_setImage(with: url,
                                        placeholderImage: UIImage(systemName: "film"))
        } else {
            posterImageView.image = UIImage(systemName: "film")
            posterImageView.tintColor = .gray
        }
    }
}
