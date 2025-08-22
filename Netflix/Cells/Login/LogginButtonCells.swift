import UIKit
import SnapKit


final class LoginButtonCell: UITableViewCell {
    static let identifier = "LoginButtonCell"
    
    let button = GradientButton(title: "Log In")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(button)
        
        button.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(50)
        }
    }
}
