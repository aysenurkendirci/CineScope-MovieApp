import Foundation

internal let authService = AuthService()

enum RegisterRow {
    case email
    case password
    case registerButton
    
    var identifier: String {
        switch self {
        case .email: return EmailCell.identifier
        case .password: return PasswordCell.identifier
        case .registerButton: return RegisterButtonCell.identifier
        }
    }
}

final class RegisterViewModel {
    let rows: [RegisterRow] = [.email, .password, .registerButton]
}

   func register(completion: @escaping (Result<User, Error>) -> Void) {
       authService.registerUser(email: email!, password: password!, completion: completion)
   }
}
