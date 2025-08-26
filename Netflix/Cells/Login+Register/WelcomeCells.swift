import UIKit
import SnapKit

protocol WelcomeCellViewProtocol {
    var title: String? { get set }
    var subtitle: String? { get set }
}

class WelcomeCellViewModel: WelcomeCellViewProtocol {
    var title: String?
    var subtitle: String?
    
    init(title: String? = nil, subtitle: String? = nil) {
        self.title = title
        self.subtitle = subtitle
    }
}

final class WelcomeCell: UICollectionViewCell {
    
    var viewModel: WelcomeCellViewProtocol? {
        didSet { updateUI() }
    }
    
    // handler eklendi
    var handler: ((String) -> Void)?
    
    private let titleLabel = UILabel.styled(
        text: "",
        font: .boldSystemFont(ofSize: 24)
    )
    
    private let subtitleLabel = UILabel.styled(
        text: "",
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
    
    private func updateUI() {
        titleLabel.text = viewModel?.title
        subtitleLabel.text = viewModel?.subtitle
    }
}
