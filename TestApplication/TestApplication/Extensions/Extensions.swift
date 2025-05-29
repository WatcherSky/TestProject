//
//  Extensions.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import Foundation
import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, okTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default))
        
        self.present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String, okTitle: String = "OK", firstButtonTitle: String,
                   firstButtonStyle: UIAlertAction.Style = .default,
                   firstButtonHandler: (() -> Void)? = nil,
                   secondButtonTitle: String,
                   secondButtonStyle: UIAlertAction.Style = .cancel,
                   secondButtonHandler: (() -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let firstAction = UIAlertAction(title: firstButtonTitle, style: firstButtonStyle) { _ in
            firstButtonHandler?()
        }
        
        let secondAction = UIAlertAction(title: secondButtonTitle, style: secondButtonStyle) { _ in
            secondButtonHandler?()
        }
        
        alert.addAction(firstAction)
        alert.addAction(secondAction)
        
        self.present(alert, animated: true)
    }
}

extension UITextField {
    func setIcon(_ image: UIImage) {
        let iconView = UIImageView(frame:
                                    CGRect(x: 10, y: (55 - 32) / 2, width: 32, height: 32))
        iconView.image = image
        let iconContainerView: UIView = UIView(frame:
                                                CGRect(x: 10, y: 0, width: 62, height: 55))
        iconContainerView.addSubview(iconView)
        leftView = iconContainerView
        leftViewMode = .always
    }
}

extension UserDefaults {
    private enum Keys {
        static let isUserLoggedIn = "user"
    }
    
    func setUserLoggedIn(_ isLoggedIn: Bool) {
        set(isLoggedIn, forKey: Keys.isUserLoggedIn)
    }
    
    func isUserLoggedIn() -> Bool {
        return bool(forKey: Keys.isUserLoggedIn)
    }
    
    func logoutUser() {
        removeObject(forKey: Keys.isUserLoggedIn)
        
    }
}
