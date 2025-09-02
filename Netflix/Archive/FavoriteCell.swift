/*import UIKit
import SnapKit
import SDWebImage

struct FavoriteCellViewModel {
    let id: Int              // film id’si
    let title: String
    let posterURL: String?
}
final class FavoriteCell: UICollectionViewCell {
    
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        posterImageView.layer.cornerRadius = 12
        posterImageView.clipsToBounds = true
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.backgroundColor = .darkGray
        
        titleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .center
        titleLabel.lineBreakMode = .byTruncatingTail
        
        contentView.addSubview(posterImageView)
        contentView.addSubview(titleLabel)
        
        posterImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(8)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(4)
            make.left.right.equalToSuperview().inset(4)
            make.bottom.lessThanOrEqualToSuperview().inset(4)
        }
    }
    
    func configure(with vm: FavoriteCellViewModel) {
        titleLabel.text = vm.title
        if let urlStr = vm.posterURL, let url = URL(string: urlStr) {
            posterImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "film"))
        } else {
            posterImageView.image = UIImage(systemName: "film")
            posterImageView.tintColor = .gray
        }
    }
 }*/
