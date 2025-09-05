import UIKit
import SnapKit

struct MessageCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: MessageCell.self) }
    let text: String
    let isUser: Bool
    func configure(cell: UICollectionViewCell) { (cell as? MessageCell)?.configure(with: self) }
}

final class MessageCell: UICollectionViewCell {
    private let bubble = UIView()
    private let label = UILabel()
    private var leading: Constraint?
    private var trailing: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame); setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        contentView.addSubview(bubble)
        bubble.layer.cornerRadius = 16
        bubble.clipsToBounds = true

        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        label.textColor = .white
        bubble.addSubview(label)

        bubble.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.78)
            leading  = make.leading.equalToSuperview().inset(12).constraint
            trailing = make.trailing.equalToSuperview().inset(12).constraint
        }
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(12) }
        backgroundColor = .clear
    }

    func configure(with vm: MessageCellViewModel) {
        label.text = vm.text
        if vm.isUser {
            bubble.backgroundColor = .systemBlue
            leading?.deactivate(); trailing?.activate()
        } else {
            bubble.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
            trailing?.deactivate(); leading?.activate()
        }
        layoutIfNeeded()
    }
}
