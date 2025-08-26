/*import UIKit
import SnapKit
//AnyObject sadece classlar,cell tetiklenince didTapRegister çağırır
protocol RegisterButtonCellDelegate: AnyObject {
    func didTapRegister()
}

final class RegisterButtonCell: UICollectionViewCell {
    weak var delegate: RegisterButtonCellDelegate?

    private let registerButton = UIButton.styled(
        title: "Create Account",
        titleColor: .white,
        background: .systemBlue,
        cornerRadius: 8
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(registerButton)
        
        registerButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
        
        registerButton.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @objc private func didTap() {
        delegate?.didTapRegister()
    }
 }*/
