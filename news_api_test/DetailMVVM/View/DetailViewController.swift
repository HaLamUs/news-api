//
//  DetailViewController.swift
//  news_api_test
//
//  Created by lamha on 3/29/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit
import WebKit
import RxSwift

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: Properties
    
    var detailViewModel = DetailViewModel()
    let disposeBag = DisposeBag()
    public let headline = PublishSubject<Headline>()
    
    // MARK: IBActions
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: View life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: Bindings
    
    func setupBindings() {
        detailViewModel
            .headline
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (headline) in
                if let url = URL(string: headline.url) {
                    self.webView.load(URLRequest(url: url))
                }
            }, onError: { (error) in
                self.showAlert(title: "Error", message: "Wrong url")
            }
        ).disposed(by: disposeBag)
    }
}
