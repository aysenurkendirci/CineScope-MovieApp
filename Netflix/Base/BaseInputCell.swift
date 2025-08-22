import UIKit
import SnapKit

class BaseInputCell: UICollectionViewCell {
    private let iconView = IconView(systemName: "square")
    private let textField = UITextField()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(iconView)
        contentView.addSubview(textField)

        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }

        textField.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

    func configure(systemIcon: String, placeholder: String, isSecure: Bool) {
        iconView.image = UIImage(systemName: systemIcon)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
    }
}

