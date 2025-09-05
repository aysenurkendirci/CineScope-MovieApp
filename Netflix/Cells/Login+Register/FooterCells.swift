import UIKit
import UIKit

struct FooterCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: FooterCell.self) }

    let text: String
    var onTap: (() -> Void)?

    func configure(cell: UICollectionViewCell) {
        (cell as? FooterCell)?.configure(with: self)
    }
}

final class FooterCell: UICollectionViewCell {
    private let label = UILabel()
    private var onTap: (() -> Void)?
    
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
        label.numberOfLines = 0
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(8) }
    }
    
    func configure(with model: FooterCellViewModel) {
        label.text = model.text
        self.onTap = model.onTap
    }
    
    private func setupTapGesture() {
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapped)))
    }
    
    @objc private func tapped() { onTap?() }
}
