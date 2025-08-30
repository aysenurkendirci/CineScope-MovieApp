enum LoginRow: RowIdentifiable {
    case welcome(WelcomeCellViewModel)
    case email(InputCellViewModel)
    case password(InputCellViewModel)
    case loginButton(ButtonCellViewModel)
    case googleButton(ButtonCellViewModel)
    case footer(FooterCellViewModel)
    
    var identifier: String {
        switch self {
        case .welcome: return String(describing: WelcomeCell.self)
        case .email, .password: return String(describing: InputCell.self)
        case .loginButton, .googleButton: return String(describing: ButtonCell.self)
        case .footer: return String(describing: FooterCell.self)
        }
    }
}
