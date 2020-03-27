//
//  LHCustomTextField.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

class LHCustomTextField: UITextField {
    
    open var leftLabel: UILabel!
    
    @IBInspectable dynamic open var iPhoneLeftViewWidth: CGFloat = 100.0 {
        didSet {
            if !Utils.isIPad() {
                updatePhoneLeftViewWidth()
            }
        }
    }
    
    @IBInspectable dynamic open var iPadLeftViewWidth: CGFloat = 200.0 {
        didSet {
            if Utils.isIPad() {
                updatePadLeftViewWidth()
            }
        }
    }
    
    @IBInspectable dynamic open var leftLabelText: String = "" {
        didSet {
            updateLeftLabelText()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLeftLabel()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLeftLabel()
    }
    
    private func createLeftLabel() {
        let leftMargin: CGFloat = Utils.isIPad() ? 30.0 : 14.0
        let topMargin: CGFloat = Utils.isIPad() ? 14.0 : 14.0
        let width: CGFloat = Utils.isIPad() ? iPadLeftViewWidth : iPhoneLeftViewWidth
        let height = self.bounds.size.height - 2 * topMargin
        let paddingView = UIView(frame: CGRect(x: 0, y: topMargin, width: width, height: height))
        
        let fontSize: CGFloat = Utils.isIPad() ? 18.0 : 12.0
        let leftLabelRect = CGRect(x: leftMargin, y: 0, width: width, height: height)
        leftLabel = UILabel(frame: leftLabelRect)
        leftLabel.font = UIFont.systemFont(ofSize: fontSize)
        
        leftLabel.textColor = UIColor.init(hexString: "19B5FE")
        paddingView.addSubview(leftLabel)
        
        leftView = paddingView
        leftViewMode = UITextField.ViewMode.always
    }
    
    private func updateLeftLabelText() {
        leftLabel.text = leftLabelText
    }
    
    private func updatePhoneLeftViewWidth() {
        if let lv = leftView {
            var leftViewFrame = lv.frame
            leftViewFrame.size.width = iPhoneLeftViewWidth
            lv.frame = leftViewFrame
            
            var leftLabelFrame = leftLabel.frame
            leftLabelFrame.size.width = iPhoneLeftViewWidth
            leftLabel.frame = leftLabelFrame
        }
    }
    
    private func updatePadLeftViewWidth() {
        if let lv = leftView {
            var leftViewFrame = lv.frame
            leftViewFrame.size.width = iPadLeftViewWidth
            lv.frame = leftViewFrame
            
            var leftLabelFrame = leftLabel.frame
            leftLabelFrame.size.width = iPadLeftViewWidth
            leftLabel.frame = leftLabelFrame
        }
    }
    
}
