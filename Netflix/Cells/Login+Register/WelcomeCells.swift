import UIKit
import SnapKit

struct WelcomeCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: WelcomeCell.self) }

    let title: String
    let subtitle: String

    func configure(cell: UICollectionViewCell) {
        (cell as? WelcomeCell)?.configure(with: self)
    }
}

final class WelcomeCell: UICollectionViewCell {
     let titleLabel = UILabel()
     let subtitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleLabel.numberOfLines = 0
        subtitleLabel.numberOfLines = 0

        titleLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
        }
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .white
        
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        subtitleLabel.textColor = .lightGray
    }
    
    func configure(with model: WelcomeCellViewModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }
}
