//
//  Constants.swift
//  TestApplication
//
//  Created by Владимир on 26.05.2025.
//

import Foundation
import UIKit

enum Constants {
    enum Login {
        enum LoginConstraints {
            static let loginImageTop = 13
            static let loginImageInset = 44
            
            static let loginFieldTop = 174
            static let passwordFieldTop = 15
            static let inset = 25
            static let loginButtonTop = 25
            static let offset = 15
            static let height = 55
        }
        
        enum LoginColors {
            static let backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0)
            static let textFieldColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
            static let imageViewColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0)
        }
        
        enum LoginCornerRadius {
            static let cornerRadius: CGFloat = 55 / 2
        }
        
        enum LoginFontSize {
            static let defaultSize: CGFloat = 15
        }
    }
    
    enum CryptoList {
        enum CryptoListColors {
            static let backgroundColor = UIColor(red: 55/255, green: 62/255, blue: 125/255, alpha: 0.05)
            static let topBackgroundColor = UIColor(red: 255/255, green: 154/255, blue: 178/255, alpha: 1.0)
        }
    }
    
    enum CryptoInfo {
        enum CryptoInfoColors {
            static let backgroundColor = UIColor(red: 243/255, green: 245/255, blue: 246/255, alpha: 1.0)
            static let bottomSheet = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
        }
    }
    
    enum Colors {
        static let bottomSheet = UIColor(red: 247/255, green: 247/255, blue: 250/255, alpha: 1.0)
        static let white = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        
        static let mainTextBlackColor = UIColor(red: 38/255, green: 39/255, blue: 60/255, alpha: 1.0)
        
        static let subColor = UIColor(red: 147/255, green: 149/255, blue: 164/255, alpha: 1.0)
        static let blackTextColor = UIColor(red: 25/255, green: 28/255, blue: 50/255, alpha: 1.0)
        
        static let whiteAlpha80 = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.8)
    }
    
    enum Images {
        static let loginImage = "loginImage"
        static let userIcon = "userIcon"
        static let passwordIcon = "passwordIcon"
    }
    
    enum Size {
        static let defaultSize = 24
        static let largeHeight: CGFloat = 70
        
        static let cellSizeSmallSize = 21
        static let cellSizeMediumSize = 27
        static let mediumSize = 30
        
    }
    
    enum Constraints {
        static let offset = 15
        static let inset = 25
        static let mediumOffset = 30
        
        static let topOffset = 30
        
        static let smallOffset = 10
        
    }
    
    
    enum Fonts {
        static func baseFont(size: CGFloat) -> UIFont {
            guard let customFont = UIFont(name: "Poppins-Regular", size: size) else { return UIFont() }
            return customFont
        }
        
        
        enum Size {
            static let defaultSmall: CGFloat = 14
            static let defaultMeduim: CGFloat = 20
            
            static let small: CGFloat = 18
            static let medium: CGFloat = 28
            static let large: CGFloat = 28
        }
    }
    
    enum Network {
        static let cryptoBaseURL = "https://data.messari.io"
    }
    
    enum ReuseIdentifiers {
        static let cryptoListCell = "cryptoListCell"
    }
}
