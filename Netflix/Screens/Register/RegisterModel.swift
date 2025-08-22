enum RegisterRow: RowIdentifiable {
    case email
    case password
    case registerButton
    
    var identifier: String {
        switch self {
        case .email: return String(describing: EmailCell.self)
        case .password: return String(describing: PasswordCell.self)
        case .registerButton: return String(describing: RegisterButtonCell.self)
        }
    }
}
