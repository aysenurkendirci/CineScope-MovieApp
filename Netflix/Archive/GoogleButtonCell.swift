/*import UIKit
import SnapKit

protocol GoogleButtonCellViewProtocol {
    var title: String? { get set }
}

public class GoogleButtonCellViewModel: GoogleButtonCellViewProtocol {
    var title: String?
    init(title: String? = "Log In with Google") {
        self.title = title
    }
}

final class GoogleButtonCell: UICollectionViewCell {
    private let googleButton = UIButton.styled(
        title: "",
        titleColor: .black,
        background: .white,
        borderColor: .lightGray,
        borderWidth: 1
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private func setupUI() {
        contentView.addSubview(googleButton)
        googleButton.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
            $0.height.equalTo(50)
        }
    }
    
    func populate(viewModel: GoogleButtonCellViewProtocol) {
        googleButton.setTitle(viewModel.title, for: .normal)
    }
 }*/
