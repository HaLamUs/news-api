//
//  HeadlineViewController.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeadlineViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var headlineTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var headlineViewModel = HeadlineViewModel()
    let disposeBag = DisposeBag()
    public var headlines = PublishSubject<[Headline]>()
    public var isLoading = PublishSubject<Bool>()
    
    // MARK: View life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        headlineViewModel.fetchHeadlines()
    }
    
    // MARK: Bindings
    
    private func setupBindings() {
        
        //binding view model
        headlineViewModel
            .error
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:
                {
                    (error) in
                    switch error {
                    case .errorDescription(let message):
                        self.showAlert(title: "Error", message: message)
                    }
            })
            .disposed(by: disposeBag)
        
        //register cell
        headlineTableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil), forCellReuseIdentifier: "HeadlineTableViewCell")
        
        // binding loading to indicator
        headlineViewModel.isLoading
            .bind(to: self.isLoading).disposed(by: disposeBag)
        
        isLoading.bind { isHidden in
            self.loadingIndicator.isHidden = !isHidden
        }.disposed(by: disposeBag)
        
        // binding headlines to headline cells
        headlineViewModel
            .headlines
            .observeOn(MainScheduler.instance)
            .bind(to: headlines)
            .disposed(by: disposeBag)
        
        headlines
            .bind(to: headlineTableView.rx.items(cellIdentifier: "HeadlineTableViewCell",
                                                 cellType: HeadlineTableViewCell.self))
            {
                ( row, headline, cell) in
                cell.headline = headline
        }
        .disposed(by: disposeBag)
        
    }
    
}

//MARK: Logic
extension HeadlineViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

