import UIKit
import FirebaseAuth

extension RegisterViewController {
    
    func performRegistration() {
        guard let email = viewModel.email, !email.isEmpty,
              let password = viewModel.password, !password.isEmpty else {
            showAlert(title: "Uyarı", message: "Lütfen email ve şifreyi doldurun.")
            return
        }
        
        AuthService.shared.register(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.showAlert(title: "Başarılı", message: "Hesap oluşturuldu.") {
                        self.navigationController?.popViewController(animated: true)
                    }
                case .failure(let error):
                    self.showAlert(title: "Kayıt Hatası", message: error.localizedDescription)
                }
            }
        }
    }
}
