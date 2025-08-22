import UIKit
import SnapKit

final class PasswordCell: UITableViewCell {
    static let identifier = "PasswordCell"
    
    private let icon = IconView(systemName: "lock")
    private let textField = CustomTextField(placeholder: "Password")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        textField.isSecureTextEntry = true
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(icon)
        contentView.addSubview(textField)
        
        icon.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(icon.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.top.bottom.equalToSuperview().inset(8)
            $0.height.equalTo(44)
        }
    }
}
