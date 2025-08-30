//
//  UIViewController+Alert.swift
//  Netflix
//
//  Created by Ayşe Nur Kendirci on 27.08.2025.
//

import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   completion: (() -> Void)? = nil) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "Tamam", style: .default) { _ in
            completion?()
        })
        present(alert, animated: true)
    }
}
