import UIKit

final class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

      
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            let loginVC = LoginViewController()
            self.navigationController?.pushViewController(loginVC, animated: true)
        }

    }
}
