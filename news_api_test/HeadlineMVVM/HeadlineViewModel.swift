//
//  HeadlineViewModel.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SwiftyJSON

class HeadlineViewModel {
    
    public let headlines : PublishSubject<[Headline]> = PublishSubject()
    public let isLoading: PublishSubject<Bool> = PublishSubject()
    public let error : PublishSubject<NetworkError> = PublishSubject()
    
    public func fetchHeadlines() {
        isLoading.onNext(true)
        
        let headlineRequestUrl = NetworkConstant.baseUrl + "?country=us&apiKey=3b5e5b72de0d466f8a9c671823880235"
        
        AF.request(headlineRequestUrl, method: .get, parameters: nil, headers: nil)
            .validate().responseJSON { response in
                self.isLoading.onNext(false)
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let headlines = json["articles"].arrayValue.compactMap {
                        return Headline(data: try! $0.rawData())
                    }
                    self.headlines.onNext(headlines)
                case .failure(let error):
                    self.error.onNext(.errorDescription("Unknown Error"))
                    print(error)
                }
        }
        
    }
    
}
