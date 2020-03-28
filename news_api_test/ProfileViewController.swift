//
//  ProfileViewController.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        nameTextField.roundCorners(corners: [.topLeft, .topRight], radius: Utils.isIPad() ? 20 : 17)
        passwordTextField.roundCorners(corners: [.bottomLeft, .bottomRight], radius: Utils.isIPad() ? 20 : 17)
        
        Utils.setupTextField(imageName: "", textField: nameTextField, placeholder: "Name", placeholderColor: UIColor.init(hexString: ColorCodes.LH_LIGHT_BLUE), backgroundColor: UIColor.white)
        Utils.setupTextField(imageName: "", textField: emailTextField, placeholder: "Email", placeholderColor: UIColor.init(hexString: ColorCodes.LH_LIGHT_BLUE), backgroundColor: UIColor.white)
        Utils.setupTextField(imageName: "", textField: passwordTextField, placeholder: "Password", placeholderColor: UIColor.init(hexString: ColorCodes.LH_LIGHT_BLUE), backgroundColor: UIColor.white)
        Utils.setupTextField(imageName: "", textField: phoneTextField, placeholder: "Phone number", placeholderColor: UIColor.init(hexString: ColorCodes.LH_LIGHT_BLUE), backgroundColor: UIColor.white)
    }
}
