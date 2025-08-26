/*import UIKit
import SnapKit

protocol LoginButtonCellDelegate: AnyObject {
    func didTapLogin()
}

protocol LoginButtonCellViewProtocol {
    var title: String? { get set }
}

public class LoginButtonCellViewModel: LoginButtonCellViewProtocol {
    var title: String?
    init(title: String? = "Log In") {
        self.title = title
    }
}

final class LoginButtonCell: UICollectionViewCell {
    let button = GradientButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
    
    func populate(viewModel: LoginButtonCellViewProtocol) {
        button.setTitle(viewModel.title, for: .normal)
    }
}
 */
