import UIKit

final class IconView: UIImageView {
    init(systemName: String) {
        super.init(frame: .zero)
        image = UIImage(systemName: systemName)
        tintColor = .gray
        contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
