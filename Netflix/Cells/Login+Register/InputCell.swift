import UIKit

protocol InputCellDelegate: AnyObject {
    func inputCell(_ cell: InputCell, didChangeText text: String)
}

struct InputCellViewModel {
    var systemIcon: String
    var placeholder: String
    var isSecure: Bool
}

final class InputCell: BaseInputCell {
    weak var delegate: InputCellDelegate?
    var viewModel: InputCellViewModel? {
        didSet { updateUI() }
    }
    
    private func updateUI() {
        guard let vm = viewModel else { return }
        configure(systemIcon: vm.systemIcon, placeholder: vm.placeholder, isSecure: vm.isSecure)
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
    }
    
    @objc private func textChanged() {
        delegate?.inputCell(self, didChangeText: textField.text ?? "")
    }
}
