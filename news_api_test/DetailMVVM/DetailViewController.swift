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
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var detailViewModel = DetailViewModel()
    let disposeBag = DisposeBag()
    public let headline = PublishSubject<Headline>()
    public var isLoading = PublishSubject<Bool>()
    
    // MARK: IBActions
    
    @IBAction func closeButtonClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: View life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.configuration.allowsInlineMediaPlayback = false
    }
    
    // MARK: Bindings
    
    func setupBindings() {
        //binding headline
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
        
        // binding loading to indicator
        detailViewModel.isLoading
            .bind(to: self.isLoading).disposed(by: disposeBag)
        
        isLoading.bind { isHidden in
            self.loadingIndicator.isHidden = !isHidden
        }.disposed(by: disposeBag)
    }
}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        detailViewModel.showWebviewStatus(isFinish: false)
    }
    
}
