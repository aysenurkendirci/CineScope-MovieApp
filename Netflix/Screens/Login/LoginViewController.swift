import UIKit
import FirebaseAuth
import FirebaseFirestore

final class LoginViewController: BaseCollectionViewController {
    
    let viewModel = LoginViewModel()
    
    private var headerSection = Section()
    private var inputSection = Section()
    private var actionSection = Section()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        buildUI()
    }
    
    private func buildUI() {
        headerSection.rows = []
        inputSection.rows = []
        actionSection.rows = []

        
        addWelcomeMessage()
        addEmailInput()
        addPasswordInput()
        addLoginButton()
        addGoogleLoginButton()
        addFooter()
        
        collectionSections = [headerSection, inputSection, actionSection]
        baseView.collectionView.reloadData()
    }
    
    private func addWelcomeMessage() {
        let vm = WelcomeCellViewModel(
            title: "Welcome back,",
            subtitle: "Glad to see you again, please login."
        )
        headerSection.rows.append(vm)
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
        inputSection.rows.append(vm)
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
        inputSection.rows.append(vm)
    }
    
    private func addLoginButton() {
        let vm = ButtonCellViewModel(
            title: "Log In",
            titleColor: .white,
            gradientColors: [UIColor.systemOrange, UIColor.systemPurple],
            onTap: { [weak self] in self?.didTapLogin() }
        )
        actionSection.rows.append(vm)
    }
    
    private func addGoogleLoginButton() {
        let vm = ButtonCellViewModel(
            title: "Log In with Google",
            titleColor: .black,
            gradientColors: nil,
            borderColor: .systemGray4,
            borderWidth: 1,
            cornerRadius: 8,
            onTap: { [weak self] in self?.didTapGoogleLogin() }
        )
        actionSection.rows.append(vm)
    }
    
    private func addFooter() {
        var vm = FooterCellViewModel(text: "Don’t have an account? Join Now")
        vm.onTap = { [weak self] in
            let registerVC = RegisterViewController()
            self?.navigationController?.pushViewController(registerVC, animated: true)
        }
        actionSection.rows.append(vm)
    }
  
    override func registerCells() {
        register([
            WelcomeCell.self,
            InputCell.self,
            ButtonCell.self,
            FooterCell.self
        ])
    }
}
