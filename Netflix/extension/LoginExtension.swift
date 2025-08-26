import UIKit
import FirebaseAuth
import FirebaseFirestore

// MARK: - LoginViewController Delegates
extension LoginViewController: InputCellDelegate {
    func inputCell(_ cell: InputCell, didChangeText text: String) {
        if cell === emailRow {
            viewModel.email = text
        } else if cell === passwordRow {
            viewModel.password = text
        }
    }
}

extension LoginViewController: ButtonCellDelegate {
    func didTapButton(_ cell: ButtonCell) {
        if cell === loginButtonRow {
            didTapLogin()
        } else if cell === googleButtonRow {
            print("Google login tapped")
        }
    }
    
    private func didTapLogin() {
        let email = viewModel.email ?? ""
        let password = viewModel.password ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            print("Email/Password boş olamaz")
            return
        }
        
        AuthService.shared.login(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("Login successful: \(user.email ?? "")")
            case .failure(let error):
                print("Login failed: \(error.localizedDescription)")
            }
        }
    }
}

extension LoginViewController: FooterCellDelegate {
    func didTapJoinNow() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

// MARK: - RegisterViewController Delegates
extension RegisterViewController: InputCellDelegate {
    func inputCell(_ cell: InputCell, didChangeText text: String) {
        if cell === emailRow {
            viewModel.email = text
        } else if cell === passwordRow {
            viewModel.password = text
        }
    }
}

extension RegisterViewController: ButtonCellDelegate {
    func didTapButton(_ cell: ButtonCell) {
        if cell === registerButtonRow {
            didTapRegister()
        }
    }
    
    private func didTapRegister() {
        let email = viewModel.email ?? ""
        let password = viewModel.password ?? ""
        
        guard !email.isEmpty, !password.isEmpty else {
            print("Email/Password boş olamaz")
            return
        }
        
        AuthService.shared.register(email: email, password: password) { result in
            switch result {
            case .success(let user):
                print("Register successful: \(user.email ?? "")")
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            case .failure(let error):
                print("Register failed: \(error.localizedDescription)")
            }
        }
    }
}

extension RegisterViewController: FooterCellDelegate {
    func didTapJoinNow() {
        navigationController?.popViewController(animated: true)
    }
}
