//
//  NewsViewController.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class NewsViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var keywordDropdown: LHCustomTextField!
    @IBOutlet weak var newsTableView: UITableView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    // MARK: Properties
    
    var keywordPicker: UIPickerView!
    var selectedKeywordIndex = 0
    var keywords = ["bitcoin", "apple", "earthquake", "animal"]
    
    var newsViewModel = NewsViewModel()
    let disposeBag = DisposeBag()
    public var headlines = PublishSubject<[Headline]>()
    public var isLoading = PublishSubject<Bool>()
    
    // MARL: Constant
    let cellId = "HeadlineTableViewCell"
    
    // MARK: View life circle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBindings()
        newsViewModel.fetchHeadlines(by: keywords[selectedKeywordIndex])
    }
    
    // MARK: Bindings
    
    func setupBindings() {
        
        //binding error
        newsViewModel
            .error // error variable
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
        newsTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        // binding loading to indicator
        newsViewModel.isLoading
            .bind(to: self.isLoading).disposed(by: disposeBag)
        
        isLoading.bind { isHidden in
            self.loadingIndicator.isHidden = !isHidden
        }.disposed(by: disposeBag)
        
        // binding headlines to headline cells
        newsViewModel
            .headlines
            .observeOn(MainScheduler.instance)
            .bind(to: headlines)
            .disposed(by: disposeBag)
        
        headlines
            .bind(to: newsTableView.rx.items(cellIdentifier: cellId,
                                                 cellType: HeadlineTableViewCell.self))
            {
                ( row, headline, cell) in
                cell.headline = headline
        }
        .disposed(by: disposeBag)
        
        newsTableView.rx.setDelegate(self)
        .disposed(by: disposeBag)
        
        newsTableView.rx.itemSelected
            .subscribe(
                onNext: {
                    indexPath in
                    let cell = self.newsTableView.cellForRow(at: indexPath) as? HeadlineTableViewCell
                    guard let headline = cell?.headline else { return }
                    self.showDetailView(headline)
            },
                onError: {
                    error in
                    self.showAlert(title: "Error", message: "Wrong cell at index")
            }
        ).disposed(by: disposeBag)
        
    }
}

//MARK: Logic

extension NewsViewController {
    
    func setupUI() {
        setupKeywordPickers()
        keywordDropdown.roundCorners()
        Utils.setupDropDowns(views: [keywordDropdown], imageName: "arrow_down_blue_icon", placeholder: ["Keyword"], placeholderColor: .lightGray)
        keywordDropdown.layer.borderWidth = 1
        keywordDropdown.layer.borderColor = UIColor(hexString: ColorCodes.LH_BLUE).cgColor
    }
    
    func setupKeywordPickers() {
        keywordPicker = UIPickerView()
        setupPicker(dropdownView: keywordDropdown, pickerView: keywordPicker, action: #selector(dismissEditingKeyword))
        keywordPicker.selectRow(0, inComponent: 0, animated: true)
        keywordDropdown.text = keywords[selectedKeywordIndex]
        
    }
    
    func setupPicker(dropdownView: UITextField, pickerView: UIPickerView, action: Selector) {
        let toolbarCentre = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: action)
        toolbarCentre.sizeToFit()
        toolbarCentre.isUserInteractionEnabled = true
        toolbarCentre.setItems([flexSpace, doneButton], animated: false)
        pickerView.delegate = self
        dropdownView.inputView = pickerView
        dropdownView.inputAccessoryView = toolbarCentre
    }
    
    @objc func dismissEditingKeyword() {
        view.endEditing(true)
        newsViewModel.fetchHeadlines(by: keywords[selectedKeywordIndex])
    }
    
    func showDetailView(_ headline: Headline) {
          let storyboard = UIStoryboard(name: "Main", bundle: nil)
          guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else { return }
          detailViewController.modalPresentationStyle = .fullScreen
          present(detailViewController, animated: false) {
              detailViewController.setupBindings()
              detailViewController.detailViewModel.openUrl(from: headline)
          }
      }
}

extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Utils.isIPad() ? 100 : 80
    }
}

extension NewsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return keywords.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return keywords[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedKeywordIndex = row
        keywordDropdown.text = keywords[row]
    }
}
