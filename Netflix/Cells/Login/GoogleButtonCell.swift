import UIKit
import SnapKit

final class GoogleButtonCell: UITableViewCell {
    static let identifier = "GoogleButtonCell"
    
    private let googleButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Log In with Google", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.backgroundColor = .white
        btn.layer.cornerRadius = 8
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor.lightGray.cgColor
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(googleButton)
        
        googleButton.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(12)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(50)
        }
    }
}
