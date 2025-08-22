import UIKit
import SnapKit

final class EmailCell: UITableViewCell {
    static let identifier = "EmailCell"
    
    private let icon = IconView(systemName: "envelope")
    private let textField = CustomTextField(placeholder: "Email")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
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
