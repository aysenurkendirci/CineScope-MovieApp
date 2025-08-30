import UIKit
import FirebaseAuth
import FirebaseFirestore

final class RegisterViewController: BaseCollectionViewController {
    
    let viewModel = RegisterViewModel()
    
    private var inputSection = Section()
    private var actionSection = Section()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buildUI()
    }
    
    private func buildUI() {
        inputSection.rows = []
        actionSection.rows = []

        addEmailInput()
        addPasswordInput()
        addRegisterButton()
        addFooter()
        
        collectionSections = [inputSection, actionSection]
        collectionView.reloadData()
    }
    
    private func addEmailInput() {
        var vm = InputCellViewModel(
            key: "email",
            systemIcon: "envelope",
            placeholder: "Email",
            isSecure: false,
            onTextChanged: nil
        )
        vm.onTextChanged = { [weak self] text in
            self?.viewModel.email = text
        }
        inputSection.rows?.append(vm)
    }
    
    private func addPasswordInput() {
        var vm = InputCellViewModel(
            key: "password",
            systemIcon: "lock",
            placeholder: "Password",
            isSecure: true,
            onTextChanged: nil
        )
        vm.onTextChanged = { [weak self] text in
            self?.viewModel.password = text
        }
        inputSection.rows?.append(vm)
    }
    
    private func addRegisterButton() {
        let vm = ButtonCellViewModel(
            title: "Create Account",
            titleColor: .white,
            gradientColors: [UIColor.systemGreen, UIColor.systemTeal],
            onTap: { [weak self] in self?.performRegistration() }
        )
        actionSection.rows?.append(vm)
    }
    
    private func addFooter() {
        var vm = FooterCellViewModel(text: "Already have an account? Log In")
        vm.onTap = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        actionSection.rows?.append(vm)
    }
    
    override func registerCells() {
        register([
            InputCell.self,
            ButtonCell.self,
            FooterCell.self
        ])
    }
}
