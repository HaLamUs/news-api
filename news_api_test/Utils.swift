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
}

extension UIView {
    
    func roundCorners(radius: CGFloat = Utils.isIPad() ? 20 : 17) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
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
