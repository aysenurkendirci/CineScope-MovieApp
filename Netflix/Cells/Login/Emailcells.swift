import UIKit
import SnapKit

final class EmailCell: BaseInputCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure(systemIcon: "envelope", placeholder: "Email", isSecure: false)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
