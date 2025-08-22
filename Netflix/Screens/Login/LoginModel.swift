enum LoginRow: RowIdentifiable {
    case welcome
    case email
    case password
    case loginButton
    case googleButton
    case footer
    
    var identifier: String {
        switch self {
        case .welcome: return String(describing: WelcomeCell.self)
        case .email: return String(describing: EmailCell.self)
        case .password: return String(describing: PasswordCell.self)
        case .loginButton: return String(describing: LoginButtonCell.self)
        case .googleButton: return String(describing: GoogleButtonCell.self)
        case .footer: return String(describing: FooterCell.self)
        }
    }
}
