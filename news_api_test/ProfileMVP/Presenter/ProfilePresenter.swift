//
//  ProfilePresenter.swift
//  news_api_test
//
//  Created by lamha on 3/28/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

class ProfilePresenter {
    
    //MARK: Properties
    
    var profile: Profile?
    var profileProtocol: ProfileProtocol?
    
    //MARK: Functions
    
    init(profile: Profile?, profileProtocol: ProfileProtocol?) {
        self.profile = profile
        self.profileProtocol = profileProtocol
        
        if let profile  = self.profile {
            self.setProfile(profile)
        }
        
    }
    
    func setProfile(_ profile: Profile) {
        guard let profileProtocol = profileProtocol else {return}
        profileProtocol.setName(profile.name)
        profileProtocol.setPhoneNumber(profile.phoneNumber)
        profileProtocol.setEmail(profile.email)
        profileProtocol.setPassword(profile.password)
    }
    
    func validateInput(name: String, phoneNumber: String, email: String,
                       password: String) -> ProfileError? {
        if name.isEmpty {
            return .emptyName
        } else if !validate(email: email){
            return .invalidEmail
        } else if !validate(phoneNumber: phoneNumber) {
            return .invalidPhoneNumber
        } else if password.isEmpty {
            return .emptyPassword
        }
        return nil
    }
    
    func validate(phoneNumber: String) -> Bool {
        let alphaNumericRegex = "^[0-9]+$"
        let alphaNumericTest = NSPredicate(format: "SELF MATCHES %@", alphaNumericRegex)
        return alphaNumericTest.evaluate(with: phoneNumber)
    }
    
    func validate(email: String) -> Bool {
        let regex = "([\\w-+]+(?:\\.[\\w-+]+)*@(?:[\\w-]+\\.)+[a-zA-Z]{2,7})"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: email)
    }
    
    func signupButtonPressed() {
        guard let profileProtocol = profileProtocol else {return}
        if let error = self.validateInput(name: profileProtocol.getName(),
                                          phoneNumber: profileProtocol.getPhoneNumber(),
                                          email: profileProtocol.getEmail(),
                                          password: profileProtocol.getPassword()) {
            
            profileProtocol.showAlert(title: "Error", message: error.localizedDescription)
        } else {
            self.saveProfileData(name: profileProtocol.getName(),
                                 phoneNumber: profileProtocol.getPhoneNumber(),
                                 email: profileProtocol.getEmail(),
                                 password: profileProtocol.getPassword() )
            
            profileProtocol.showAlert(title: "Success", message: "The profile updated successfully")
        }
    }
    
    func saveProfileData(name: String, phoneNumber: String, email: String, password: String) {
        self.updateLocalProfile(name: name, phoneNumber: phoneNumber, email: email, password: password)
        self.updateProfile(name: name, phoneNumber: phoneNumber, email: email, password: password)
    }
    
    func updateLocalProfile(name: String, phoneNumber: String, email: String, password: String) {
        if ProfileStorage.default.profile == nil {
            ProfileStorage.default.profile = Profile(name: name, phoneNumber: phoneNumber, email: email, password: password)
        } else {
            ProfileStorage.default.profile?.name = name
            ProfileStorage.default.profile?.phoneNumber = phoneNumber
            ProfileStorage.default.profile?.password = password
            ProfileStorage.default.profile?.email = email
        }
        ProfileStorage.default.saveProfile()
    }
    
    func updateProfile(name: String, phoneNumber: String, email: String, password: String) {
        self.profile?.name = name
        self.profile?.phoneNumber = phoneNumber
        self.profile?.email = email
        self.profile?.password = password
        
    }
    
}
