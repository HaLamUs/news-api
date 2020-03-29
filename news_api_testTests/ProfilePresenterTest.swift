//
//  ProfilePresenterTest.swift
//  news_api_testTests
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import XCTest

class ProfilePresenterTest: XCTestCase {
    
    var profilePresenter: ProfilePresenter!
    
    override func setUp() {
        profilePresenter = ProfilePresenter(profile: nil, profileProtocol: nil)
    }
    
    override func tearDown() {
        profilePresenter = nil
    }
    
    func testSetProfile() {
        let profile = Profile(name: "Ha Lam", phoneNumber: "09872288833", email: "itzlamz9x@gmail.com", password: "1111")
        profilePresenter.setProfile(profile)
        XCTAssert(profilePresenter.profileProtocol != nil, "ProfileProtocol must not be nil")
    }
    
}
