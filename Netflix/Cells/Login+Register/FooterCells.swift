import UIKit
import SnapKit

protocol FooterCellDelegate: AnyObject {
    func didTapJoinNow()
}

protocol FooterCellViewProtocol {
    var text: String? { get set }
}

class FooterCellViewModel: FooterCellViewProtocol {
    var text: String?
    init(text: String? = "Don’t have an account? Join Now") {
        self.text = text
    }
}

final class FooterCell: UICollectionViewCell {
    weak var delegate: FooterCellDelegate?
    var viewModel: FooterCellViewProtocol? {
        didSet { updateUI() }
    }
    
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTapGesture()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(label)
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
    }
    
    private func updateUI() {
        label.text = viewModel?.text
    }
    
    private func setupTapGesture() {
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(joinNowTapped))
        label.addGestureRecognizer(tap)
    }
    
    @objc private func joinNowTapped() {
        delegate?.didTapJoinNow()
    }
}

