import UIKit
import FirebaseAuth

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
    
    private func switchToMainTabBar() {
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
              let window = sceneDelegate.window else { return }
        
        window.rootViewController = MainTabBarController()
        window.makeKeyAndVisible()
    }
}
