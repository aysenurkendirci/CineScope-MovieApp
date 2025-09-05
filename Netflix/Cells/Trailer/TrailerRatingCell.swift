import UIKit
import SnapKit

struct TrailerRatingViewModel: CellConfigurator {
    static var reuseId: String { String(describing: TrailerRatingCell.self) }

    let average: Double
    let totalReviews: Int
    let breakdown: [Int: Int]

    func configure(cell: UICollectionViewCell) {
        (cell as? TrailerRatingCell)?.configure(with: self)
    }
}

final class TrailerRatingCell: UICollectionViewCell {
    
    private let ratingLabel = UILabel()
    private let reviewsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        ratingLabel.font = .boldSystemFont(ofSize: 18)
        ratingLabel.textColor = .yellow
        
        reviewsLabel.font = .systemFont(ofSize: 14)
        reviewsLabel.textColor = .lightGray
        
        let stack = UIStackView(arrangedSubviews: [ratingLabel, reviewsLabel])
        stack.axis = .vertical
        stack.spacing = 4
        contentView.addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }
    
    func configure(with vm: TrailerRatingViewModel) {
        ratingLabel.text = "⭐️ \(vm.average)"
        reviewsLabel.text = "\(vm.totalReviews) reviews"
    }
}
