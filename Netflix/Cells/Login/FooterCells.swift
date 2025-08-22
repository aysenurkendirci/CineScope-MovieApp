import UIKit
import SnapKit

final class FooterCell: UITableViewCell {
    static let identifier = "FooterCell"
    
    private let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(label)
        label.text = "Don’t have an account? Join Now"
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .center
        label.textColor = .darkGray
        
        label.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}
