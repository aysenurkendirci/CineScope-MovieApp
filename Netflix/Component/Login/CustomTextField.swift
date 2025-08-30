import UIKit

final class CustomTextField: UITextField {
    init(placeholder: String, isSecure: Bool = false) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        isSecureTextEntry = isSecure
        
        borderStyle = .none
        autocapitalizationType = .none
        textColor = .white
        font = .systemFont(ofSize: 16)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
