import UIKit

final class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        self.placeholder = placeholder
        borderStyle = .roundedRect
        autocapitalizationType = .none
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
