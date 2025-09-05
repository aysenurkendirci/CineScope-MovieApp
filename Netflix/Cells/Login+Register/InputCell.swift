import UIKit
import SnapKit

// MARK: - ViewModel
struct InputCellViewModel: CellConfigurator {
    static var reuseId: String { String(describing: InputCell.self) }

    var key: String
    var systemIcon: String
    var placeholder: String
    var isSecure: Bool
    var onTextChanged: ((String) -> Void)?

    func configure(cell: UICollectionViewCell) {
        (cell as? InputCell)?.configure(
            systemIcon: systemIcon,
            placeholder: placeholder,
            isSecure: isSecure,
            onTextChanged: onTextChanged
        )
    }
}

// MARK: - Cell
final class InputCell: UICollectionViewCell {
    private let iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.tintColor = .lightGray
        return iv
    }()
    
    private let textField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .none
        tf.autocapitalizationType = .none
        tf.textColor = .white
        tf.font = .systemFont(ofSize: 16, weight: .medium)
        return tf
    }()
    
    private var onTextChanged: ((String) -> Void)?
    
    override init(frame: CGRect) {
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
        
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    func configure(systemIcon: String,
                   placeholder: String,
                   isSecure: Bool,
                   onTextChanged: ((String) -> Void)? = nil) {
        iconView.image = UIImage(systemName: systemIcon)
        textField.placeholder = placeholder
        textField.isSecureTextEntry = isSecure
        self.onTextChanged = onTextChanged
        
        textField.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 15)
            ]
        )
        
        // Content type ayarı
        switch placeholder.lowercased() {
        case "email":
            textField.textContentType = .emailAddress
            textField.keyboardType = .emailAddress
        case "password":
            textField.textContentType = .password
            textField.isSecureTextEntry = true
        default:
            textField.textContentType = .none
        }
    }
    
    @objc private func textChanged() {
        onTextChanged?(textField.text ?? "")
    }
}
