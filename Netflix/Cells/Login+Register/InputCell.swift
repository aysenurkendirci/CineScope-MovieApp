import UIKit

struct InputCellViewModel {
    var key: String
    var systemIcon: String
    var placeholder: String
    var isSecure: Bool
    var onTextChanged: ((String) -> Void)?
}

final class InputCell: BaseInputCell {
    private var onTextChanged: ((String) -> Void)?
    
    func configure(with model: InputCellViewModel) {
        configure(systemIcon: model.systemIcon,
                  placeholder: model.placeholder,
                  isSecure: model.isSecure)
        
        self.onTextChanged = model.onTextChanged
        
        // Görünüm ayarları
        textField.textColor = .white
        textField.font = .systemFont(ofSize: 16, weight: .medium)
        textField.attributedPlaceholder = NSAttributedString(
            string: model.placeholder,
            attributes: [
                .foregroundColor: UIColor.lightGray,
                .font: UIFont.systemFont(ofSize: 15)
            ]
        )
        iconView.tintColor = .lightGray
        
        // Content type
        if model.key.lowercased() == "email" {
            textField.textContentType = .emailAddress
            textField.keyboardType = .emailAddress
        } else if model.key.lowercased() == "password" {
            textField.textContentType = .password
            textField.isSecureTextEntry = true
        } else {
            textField.textContentType = .none
        }
        

        textField.removeTarget(self, action: #selector(textChanged), for: .editingChanged)
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc private func textChanged() {
        onTextChanged?(textField.text ?? "")
    }
}
