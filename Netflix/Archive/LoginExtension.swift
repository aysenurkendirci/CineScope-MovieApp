/*import UIKit
import FirebaseAuth
import FirebaseFirestore

extension LoginViewController {
    
    func didTapLogin() {
        guard let email = viewModel.email, !email.isEmpty,
              let password = viewModel.password, !password.isEmpty else {
            showAlert(title: "Uyarı", message: "Lütfen email ve şifreyi doldurun.")
            return
        }
        
        AuthService.shared.login(email: email, password: password) { [weak self] in
            self?.handleAuthResult($0)
        }
    }
    
    func didTapGoogleLogin() {
        AuthService.shared.signInWithGoogle(presentingVC: self) { [weak self] in
            self?.handleAuthResult($0)
        }
    }
    private func handleAuthResult(_ result: Result<User, Error>) {
        DispatchQueue.main.async { [weak self] in
            switch result {
            case .success:
                self?.switchToMainTabBar()
            case .failure:
                self?.showAlert(title: "Giriş Hatası", message: "E-posta veya şifre hatalı.")
            }
        }
    }
    //başarılı ise geçiş
    private func switchToMainTabBar() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
    }
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Tamam", style: .default))
        present(alert, animated: true)
    }
 }*/
