//
//  NewsViewController.swift
//  news_api_test
//
//  Created by lamha on 3/27/20.
//  Copyright © 2020 lam.pte. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet weak var keywordDropdown: LHCustomTextField!
    
    var keywordPicker: UIPickerView!
    var selectedKeywordIndex = 0
    var keywords = ["bitcoin", "apple", "earthquake", "animal"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
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
