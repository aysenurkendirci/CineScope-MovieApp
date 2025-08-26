import UIKit
import SnapKit

protocol ButtonCellDelegate: AnyObject {
    func didTapButton(_ cell: ButtonCell)
}

struct ButtonCellViewModel {
    var title: String
    var backgroundColor: UIColor
    var titleColor: UIColor
    var borderColor: UIColor? = nil
    var borderWidth: CGFloat = 0
    var cornerRadius: CGFloat = 8
}

final class ButtonCell: UICollectionViewCell {
    weak var delegate: ButtonCellDelegate?
    var viewModel: ButtonCellViewModel? {
        didSet { updateUI() }
    }
    
    private let button = UIButton(type: .system)
    
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
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(didTap), for: .touchUpInside)
    }
    
    private func updateUI() {
        guard let vm = viewModel else { return }
        button.setTitle(vm.title, for: .normal)
        button.backgroundColor = vm.backgroundColor
        button.setTitleColor(vm.titleColor, for: .normal)
        button.layer.cornerRadius = vm.cornerRadius
        button.layer.borderColor = vm.borderColor?.cgColor
        button.layer.borderWidth = vm.borderWidth
    }
    
    @objc private func didTap() {
        delegate?.didTapButton(self)
    }
}
