//
//  Headline.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation

struct Headline: Codable {
    
    let author, title, description, url, urlToImage, publishedAt, content: String
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, urlToImage, publishedAt ,content
    }
}
extension Headline {
    
    init?(data: Data) {
        do {
            let headline = try JSONDecoder().decode(Headline.self, from: data)
            self = headline
        }
        catch {
            print(error)
            return nil
        }
    }
}
