import UIKit
import SnapKit

struct ChatBubbleCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: ChatBubbleCell.self) }
    let message: ChatMessage
    func configure(cell: UICollectionViewCell) {
        (cell as? ChatBubbleCell)?.configure(with: self)
    }
}

final class ChatBubbleCell: UICollectionViewCell {

    private let bubble = UIView()
    private let label = UILabel()
    private var leading: Constraint?
    private var trailing: Constraint?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setup() {
        contentView.backgroundColor = .clear

        bubble.layer.cornerRadius = 16
        bubble.layer.masksToBounds = true

        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)

        contentView.addSubview(bubble)
        bubble.addSubview(label)

        bubble.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(6)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.75)
            leading = make.leading.equalToSuperview().constraint
            trailing = make.trailing.equalToSuperview().constraint
        }
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(12)
        }
    }

    func configure(with vm: ChatBubbleCellViewModel) {
        let isUser = (vm.message.role == .user)
        label.text = vm.message.text
        label.textColor = isUser ? .white : .black
        bubble.backgroundColor = isUser ? UIColor.systemBlue : UIColor(white: 0.9, alpha: 1.0)

        if isUser {
            leading?.deactivate(); trailing?.activate()
        } else {
            trailing?.deactivate(); leading?.activate()
        }
    }
}
