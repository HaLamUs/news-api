//
//  ProfileError.swift
//  news_api_test
//
//  Created by lamha on 3/28/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

enum ProfileError: Error {
    
    case emptyName
    case invalidPhoneNumber
    case invalidEmail
    case emptyPassword
    
    var localizedDescription: String {
        switch self {
        case .emptyName:
            return "User name is empty"
        case .invalidPhoneNumber:
            return "Phone number is invalid"
        case .invalidEmail:
            return "Email is invalid"
        case .emptyPassword:
            return "Password is empty"
        }
    }
    
}
