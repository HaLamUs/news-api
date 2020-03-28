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
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(profile) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: keyProfile)
        }
    }
    
    func getProfile() -> Profile? {
        let defaults = UserDefaults.standard
        if let profileData = defaults.object(forKey: keyProfile) as? Data {
            let decoder = JSONDecoder()
            if let profile = try? decoder.decode(Profile.self, from: profileData) {
                return profile
            }
        }
        return nil
    }
}
