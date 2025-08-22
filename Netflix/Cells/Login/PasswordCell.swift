import UIKit
import SnapKit

final class PasswordCell: BaseInputCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(systemIcon: "lock", placeholder: "Password", isSecure: true)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
