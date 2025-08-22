import UIKit
import SnapKit


final class LoginButtonCell: UICollectionViewCell {
    let button = GradientButton(title: "Log In")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
