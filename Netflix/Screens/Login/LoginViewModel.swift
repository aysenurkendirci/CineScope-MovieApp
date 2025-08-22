internal let authService = AuthService()
enum LoginRow {
    case welcome, email, password, loginButton, googleButton, footer
    
    var identifier: String {
        switch self {
        case .welcome: return WelcomeCell.identifier
        case .email: return EmailCell.identifier
        case .password: return PasswordCell.identifier
        case .loginButton: return LoginButtonCell.identifier
        case .googleButton: return GoogleButtonCell.identifier
        case .footer: return FooterCell.identifier
        }
    }
}

final class LoginViewModel {
    let rows: [LoginRow] = [
        .welcome,
        .email,
        .password,
        .loginButton,
        .googleButton,
        .footer
    ]
    func login(completion: @escaping (Result<User, Error>) -> Void) {
           // email ve password'u kontrol et
           authService.loginUser(email: email!, password: password!, completion: completion)
       }
       
       func signInWithGoogle(presentingViewController: UIViewController, completion: @escaping (Result<User, Error>) -> Void) {
           authService.signInWithGoogle(presentingViewController: presentingViewController, completion: completion)
       }
   }
}
