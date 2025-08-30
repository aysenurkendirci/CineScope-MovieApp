enum RegisterRow: RowIdentifiable {
    case email(InputCellViewModel)
    case password(InputCellViewModel)
    case registerButton(ButtonCellViewModel)
    case footer(FooterCellViewModel)
    
    var identifier: String {
        switch self {
        case .email, .password: return String(describing: InputCell.self)
        case .registerButton: return String(describing: ButtonCell.self)
        case .footer: return String(describing: FooterCell.self)
        }
    }
}
