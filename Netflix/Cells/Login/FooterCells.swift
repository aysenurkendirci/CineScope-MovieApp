import UIKit
import SnapKit

protocol FooterCellDelegate: AnyObject {
    func didTapJoinNow()
}

final class FooterCell: UICollectionViewCell {
    weak var delegate: FooterCellDelegate?
    private let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupTapGesture()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(label)
        label.text = "Don’t have an account? Join Now"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
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
