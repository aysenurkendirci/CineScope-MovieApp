// AvatarCell.swift
import UIKit
import SnapKit
import SDWebImage

struct AvatarCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: AvatarCell.self) }
    let url: URL
    func configure(cell: UICollectionViewCell) { (cell as? AvatarCell)?.configure(with: self) }
}

final class AvatarCell: UICollectionViewCell {
    private let imageView = UIImageView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = UIColor(white: 0.12, alpha: 1)

        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { $0.edges.equalToSuperview() }
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(with vm: AvatarCellViewModel) {
        imageView.sd_setImage(with: vm.url,
                              placeholderImage: UIImage(systemName: "person.circle"),
                              options: [.retryFailed, .continueInBackground])
    }
}
