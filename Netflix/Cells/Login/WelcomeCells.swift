import UIKit
import SnapKit

final class WelcomeCell: UITableViewCell {
    static let identifier = "WelcomeCell"
    
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        titleLabel.text = "Welcome back,"
        titleLabel.font = .boldSystemFont(ofSize: 24)
        
        subtitleLabel.text = "Glad to meet you again, please login to use the app."
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .darkGray
        subtitleLabel.numberOfLines = 2 //metnin kaç satıra yayılıcağını belirtir
        
        //snapkit auto layout kısıtlamalri
        titleLabel.snp.makeConstraints {//
            $0.top.equalToSuperview().offset(20) //kısıtlamayı content viewe göre ayarlıyor
            $0.leading.trailing.equalToSuperview().inset(20)//sol ve sağ kenarlarını, contentView'in sol ve sağ kenarlarına hizalar
        }
        
        subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalTo(titleLabel)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}
