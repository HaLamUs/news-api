//
//  ProfileProtocol.swift
//  news_api_test
//
//  Created by lamha on 3/28/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

protocol ProfileProtocol {
    // MARK: Setters
    
    func setName(_ name: String)
    func setPhoneNumber(_ phoneNumber: String)
    func setEmail(_ email: String)
    func setPassword(_ password: String)
    
    // MARK: Getters
    
    func getName() -> String
    func getPhoneNumber() -> String
    func getEmail() -> String
    func getPassword() -> String
    
    // MARK: Logic
    func showAlert(title: String, message: String)
}
