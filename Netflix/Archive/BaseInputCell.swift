/*import UIKit
import SnapKit

class BaseInputCell: UICollectionViewCell {
    let iconView: IconView
    let textField: CustomTextField
   
    override init(frame: CGRect) {
        self.iconView = IconView(systemName: "square.and.pencil")
        self.textField = CustomTextField(placeholder: "")
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconView)
        contentView.addSubview(textField)
        
        iconView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
        }
        
        textField.snp.makeConstraints {
            $0.leading.equalTo(iconView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.height.equalTo(40)
        }
    }
    func configure(systemIcon: String, placeholder: String, isSecure: Bool) {
        iconView.image = UIImage(systemName: systemIcon)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
    }
 }*/
