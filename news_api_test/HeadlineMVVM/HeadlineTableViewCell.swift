//
//  HeadlineTableViewCell.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

class HeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var headlineImageView: UIImageView!
    @IBOutlet weak var headLineContentLabel: UILabel!
    
    public var headline : Headline! {
        didSet {
            headLineContentLabel.text = headline.title
            headlineImageView.loadImage(fromURL: headline.urlToImage)
        }
    }
}
