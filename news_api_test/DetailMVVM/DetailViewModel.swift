//
//  DetailViewModel.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    public let headline: PublishSubject<Headline> = PublishSubject()
    
    public func openUrl(from headline: Headline) {
        self.headline.onNext(headline)
    }
}
