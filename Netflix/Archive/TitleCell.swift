/*import UIKit
import SnapKit

struct TitleCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: TitleCell.self) }
    let text: String
    func configure(cell: UICollectionViewCell) { (cell as? TitleCell)?.configure(text: text) }
}

final class TitleCell: UICollectionViewCell {
    private let label = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        contentView.addSubview(label)
        label.snp.makeConstraints { $0.edges.equalToSuperview().inset(12) }
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(text: String) { label.text = text }
}
 */
