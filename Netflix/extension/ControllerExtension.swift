import UIKit

// MARK: - Register Buton Delegate
extension RegisterViewController: RegisterButtonCellDelegate {
    func didTapRegister() {
        print("Register button tapped!")
    }
}

// MARK: - Login Footer Delegate
extension LoginViewController: FooterCellDelegate {
    func didTapJoinNow() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

// MARK: - Cell Identifier
extension UICollectionViewCell {
    static var identifier: String {
        String(describing: self)
    }
}

