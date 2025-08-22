import UIKit
import SnapKit

final class WelcomeCell: UICollectionViewCell {
    private let titleLabel = UILabel.styled(
        text: "Welcome back,",
        font: .boldSystemFont(ofSize: 24)
    )
    
    private let subtitleLabel = UILabel.styled(
        text: "Glad to meet you again, please login to use the app.",
        font: .systemFont(ofSize: 14),
        color: .darkGray,
        alignment: .left,
        lines: 2
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
