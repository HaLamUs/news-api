//
//  ProfileViewController.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    //MARK: Properties
    
    var profilePresenter: ProfilePresenter!
    
    //MARK: IBActions
    
    @IBAction func signupButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        self.profilePresenter.signupButtonPressed()
    }
    //MARK: View Life Circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadData()
    }
    
}

// MARK: Logic
extension ProfileViewController {
    
    func loadData() {
        let profile = ProfileStorage.default.profile
        profilePresenter = ProfilePresenter(profile: profile, profileProtocol: self)
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

extension ProfileViewController: ProfileProtocol {
    // MARK: Setters
    
    func setName(_ name: String) {
        nameTextField.text = name
    }
    
    func setPhoneNumber(_ phoneNumber: String) {
        phoneTextField.text = phoneNumber
    }
    
    func setEmail(_ email: String) {
        emailTextField.text = email
    }
    
    func setPassword(_ password: String) {
        passwordTextField.text = password
    }
    
    // MARK: Getters
    
    func getName() -> String {
        return nameTextField.text ?? ""
    }
    
    func getPhoneNumber() -> String {
        return phoneTextField.text ?? ""
    }
    
    func getEmail() -> String {
        return emailTextField.text ?? ""
    }
    
    func getPassword() -> String {
        return passwordTextField.text ?? ""
    }
    
    // MARK: Logic
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
