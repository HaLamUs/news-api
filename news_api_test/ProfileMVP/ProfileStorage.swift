//
//  ProfileStorage.swift
//  news_api_test
//
//  Created by lamha on 3/28/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

class ProfileStorage {
    
    var profile: Profile?
    static let `default` = ProfileStorage()
    let keyProfile = "news_profile"
    
    init() {
        profile = getProfile()
    }
    
    func saveProfile() {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(profile), forKey: keyProfile)
    }
    
    func getProfile() -> Profile? {
        if let profileData = UserDefaults.standard.value(forKey: keyProfile) as? Data {
            let profile = try? PropertyListDecoder().decode(Profile.self, from: profileData)
            return profile
        }
        return nil
    }
}
