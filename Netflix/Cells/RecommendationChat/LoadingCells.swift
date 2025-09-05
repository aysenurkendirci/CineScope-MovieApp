import UIKit
import Foundation

final class LoadingCell: UICollectionViewCell {
    private let spinner = UIActivityIndicatorView(style: .medium)
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(spinner)
        spinner.color = .white
        spinner.snp.makeConstraints { $0.center.equalToSuperview() }
        backgroundColor = .clear
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    func configure() { spinner.startAnimating() }
}

struct LoadingCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: LoadingCell.self) }
    func configure(cell: UICollectionViewCell) { (cell as? LoadingCell)?.configure() }
}

