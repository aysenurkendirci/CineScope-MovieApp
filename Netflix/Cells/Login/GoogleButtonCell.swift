import UIKit
import SnapKit

final class GoogleButtonCell: UICollectionViewCell {
    private let googleButton = UIButton.styled(
        title: "Log In with Google",
        titleColor: .black,
        background: .white,
        borderColor: .lightGray,
        borderWidth: 1
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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

