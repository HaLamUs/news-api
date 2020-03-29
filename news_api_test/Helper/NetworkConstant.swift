//
//  NetworkConstant.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

struct NetworkConstant {
    
    static let baseUrl = "https://newsapi.org/v2/"
}

public enum NetworkError {
    case errorDescription(String)
}
