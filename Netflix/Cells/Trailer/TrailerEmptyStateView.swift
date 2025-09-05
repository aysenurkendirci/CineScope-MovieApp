import UIKit
import SnapKit

final class TrailerEmptyStateView: UIView {
    
    var onBrowseTapped: (() -> Void)?
    var onDailyTapped: (() -> Void)?
    
    private let messageLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Henüz bir film seçmediniz"
        lbl.textColor = .white
        lbl.font = .boldSystemFont(ofSize: 22)
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let browseButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("İçeriklere Göz At", for: .normal)
        btn.backgroundColor = .systemRed
        btn.tintColor = .white
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    private let dailyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Günün Filmi", for: .normal)
        btn.backgroundColor = .darkGray
        btn.tintColor = .white
        btn.layer.cornerRadius = 10
        btn.titleLabel?.font = .boldSystemFont(ofSize: 16)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        let stack = UIStackView(arrangedSubviews: [messageLabel, browseButton, dailyButton])
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .fill
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(32)
        }
        
        browseButton.snp.makeConstraints { $0.height.equalTo(50) }
        dailyButton.snp.makeConstraints { $0.height.equalTo(50) }
        
        browseButton.addTarget(self, action: #selector(didTapBrowse), for: .touchUpInside)
        dailyButton.addTarget(self, action: #selector(didTapDaily), for: .touchUpInside)
    }
    
    @objc private func didTapBrowse() {
        onBrowseTapped?()
    }
    
    @objc private func didTapDaily() {
        onDailyTapped?()
    }
}
