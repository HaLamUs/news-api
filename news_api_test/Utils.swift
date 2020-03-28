//
//  Utils.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

struct Utils {
    
    static func isIPad() -> Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    static func setupDropDowns(views: [UITextField], imageName: String, placeholder: [String], placeholderColor: UIColor) {
        for (i, view) in views.enumerated() {
            setupDropDown(imageName: imageName, textField: view, placeholder: placeholder[i], placeholderColor: placeholderColor)
        }
    }
    
    static func setupDropDown(imageName: String, textField: UITextField, placeholder: String, placeholderColor: UIColor) {
        let imageView = UIImageView(frame: isIPad()
            ? CGRect(x: 0, y: 0, width: 20, height: 20)
            : CGRect(x: 0, y: 0, width: 15, height: 15))
        
        let image = UIImage(named: imageName)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = false
        
        let iconContainerView = UIView(frame: isIPad()
            ? CGRect(x: 0, y: 0, width: 40, height: 20)
            : CGRect(x: 0, y: 0, width: 30, height: 15))
        iconContainerView.addSubview(imageView)
        iconContainerView.isUserInteractionEnabled = false
        
        textField.rightView = iconContainerView
        textField.rightViewMode = .always
        
        textField.tintColor = UIColor.clear
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                             attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
    
    static func setupTextField(imageName: String, textField: UITextField, placeholder: String, placeholderColor: UIColor, backgroundColor: UIColor) {
        let imageView = UIImageView(frame: isIPad()
            ? CGRect(x: 10, y: 5, width: 30, height: 30)
            : CGRect(x: 10, y: 5, width: 20, height: 20))
        
        let image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFit
        imageView.image = image
        
        let iconContainerView = UIView(frame: isIPad()
            ? CGRect(x: 20, y: 0, width: 40, height: 40)
            : CGRect(x: 20, y: 0, width: 26, height: 30))
        iconContainerView.addSubview(imageView)
        
        textField.leftViewMode = .always
        textField.leftView = iconContainerView
        textField.backgroundColor = backgroundColor
        textField.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                                     attributes: [NSAttributedString.Key.foregroundColor: placeholderColor])
    }
}

struct ColorCodes {
    static let LH_BLUE = "19B5FE"
    static let LH_LIGHT_BLUE = "65C1E9"
    static let LH_DARK_BLUE = "1D304C"
    static let LH_GREY = "D9D9D6"
    static let LH_ORANGE = "FF9900"
    static let LH_GREEN = "C4D600"
    static let LH_YELLOW = "F1E219"
    static let LH_PINK = "EC008C"
}

extension UIView {
    
    func roundCorners(radius: CGFloat = Utils.isIPad() ? 20 : 17) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat = Utils.isIPad() ? 20 : 17) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}
