//
//  ViewExtension.swift
//  Netflix
//
//  Created by Ayşe Nur Kendirci on 22.08.2025.
//

import Foundation
import UIKit
 //Cellerin içinde
extension UIButton {
    static func styled(title: String,
                       titleColor: UIColor = .white,
                       background: UIColor = .systemBlue,
                       cornerRadius: CGFloat = 8,
                       borderColor: UIColor? = nil,
                       borderWidth: CGFloat = 0) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(title, for: .normal)
        btn.setTitleColor(titleColor, for: .normal)
        btn.backgroundColor = background
        btn.layer.cornerRadius = cornerRadius
        if let borderColor = borderColor {
            btn.layer.borderColor = borderColor.cgColor
            btn.layer.borderWidth = borderWidth
        }
        return btn
    }
}

extension UILabel {
    static func styled(text: String,
                       font: UIFont = .systemFont(ofSize: 14),
                       color: UIColor = .darkGray,
                       alignment: NSTextAlignment = .left,
                       lines: Int = 1) -> UILabel {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = color
        label.textAlignment = alignment
        label.numberOfLines = lines
        return label
    }
    
}
