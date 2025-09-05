/*import UIKit
import SnapKit

struct MessageCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: MessageCell.self) }
    let text: String
    func configure(cell: UICollectionViewCell) { (cell as? MessageCell)?.configure(text: text) }
}

final class MessageCell: UICollectionViewCell {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.textColor = .lightGray
        label.numberOfLines = 0
        label.textAlignment = .center
        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(text: String) { label.text = text }
}
 */
