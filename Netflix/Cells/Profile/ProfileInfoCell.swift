// ProfileInfoCell.swift
import UIKit
import SnapKit
import SDWebImage

protocol ProfileInfoCellDelegate: AnyObject {
    func profileInfoCellDidTapAvatar(_ cell: ProfileInfoCell)
}

struct ProfileInfoCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: ProfileInfoCell.self) }
    let email: String
    let avatarURL: String?
    weak var delegate: ProfileInfoCellDelegate?
    func configure(cell: UICollectionViewCell) { (cell as? ProfileInfoCell)?.configure(with: self) }
}

final class ProfileInfoCell: UICollectionViewCell {
    private let avatarBg = UIView()
    private let avatarView = UIImageView()
    private let emailLabel = UILabel()
    private weak var delegate: ProfileInfoCellDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame); setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    private func setupUI() {
        contentView.backgroundColor = UIColor(white: 0.10, alpha: 1)
        contentView.layer.cornerRadius = 16

        avatarBg.backgroundColor = UIColor(white: 0.15, alpha: 1)
        avatarBg.layer.cornerRadius = 50
        avatarBg.layer.borderWidth = 1
        avatarBg.layer.borderColor = UIColor.darkGray.cgColor

        avatarView.contentMode = .scaleAspectFill
        avatarView.layer.cornerRadius = 44
        avatarView.clipsToBounds = true

        emailLabel.font = .systemFont(ofSize: 15, weight: .medium)
        emailLabel.textColor = .white
        emailLabel.textAlignment = .center

        let stack = UIStackView(arrangedSubviews: [avatarBg, emailLabel])
        stack.axis = .vertical; stack.spacing = 12; stack.alignment = .center
        contentView.addSubview(stack)
        stack.snp.makeConstraints { $0.edges.equalToSuperview().inset(16) }

        avatarBg.snp.makeConstraints { $0.size.equalTo(CGSize(width: 100, height: 100)) }
        avatarBg.addSubview(avatarView)
        avatarView.snp.makeConstraints { $0.center.equalToSuperview(); $0.size.equalTo(CGSize(width: 88, height: 88)) }

        let tap = UITapGestureRecognizer(target: self, action: #selector(didTapAvatar))
        avatarBg.isUserInteractionEnabled = true
        avatarBg.addGestureRecognizer(tap)
    }

    @objc private func didTapAvatar() { delegate?.profileInfoCellDidTapAvatar(self) }

    func configure(with vm: ProfileInfoCellViewModel) {
        delegate = vm.delegate
        emailLabel.text = vm.email
        if let s = vm.avatarURL, let url = URL(string: s) {
            avatarView.sd_setImage(with: url,
                                   placeholderImage: UIImage(systemName: "person.fill"),
                                   options: [.retryFailed, .continueInBackground])
        } else {
            avatarView.image = UIImage(systemName: "person.fill")
            avatarView.tintColor = .lightGray
        }
    }
}
