//
//  ViewController.swift
//  TextFieldCurrencyFormat
//
//  Created by Vivatum on 1/25/17.
//  Copyright © 2017 vivatum. All rights reserved.
//

import UIKit

final class CurrencyViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var currencyTextField: UITextField!
    
    private var pickerView = UIPickerView()
    fileprivate var dataSource: CurrencyPickerDataSource!
    
    private var needToShowPicker = false {
        didSet {
            self.handlePickerShowStatus()
        }
    }
    
    private var currentCurrency: Currency? {
        didSet {
            self.updateCurrencyText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentCurrency = .USD
        
        self.setupPickerView()
        self.setupGesture()
        self.dataSource = CurrencyPickerDataSource()
        
        currencyTextField.addTarget(self, action: #selector(myTextFieldDidChange), for: .editingChanged)
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardIfShown))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    private func updateCurrencyText() {
        guard let currency = self.currentCurrency else { return }
        DispatchQueue.main.async {
            self.currencyTextField.placeholder = "\(currency.rawValue)0.00"
            self.currencyTextField.text = self.currencyTextField.text?.currencyInputFormatting(currency)
        }
    }
    

    // MARK: - Actions
    
    @IBAction func switchButtonAction(_ sender: UIButton) {
        self.currencyTextField.resignFirstResponder()
        self.needToShowPicker.toggle()
    }
    
    @objc func myTextFieldDidChange(_ textField: UITextField) {
        self.updateCurrencyText()
    }
    
    @objc func hideKeyboardIfShown() {
        if self.needToShowPicker {
            self.needToShowPicker.toggle()
        }
    }
    
    
    // MARK: - PickerView
    
    private func setupPickerView() {
        let frame = CGRect(x: 0, y: self.view.bounds.height, width: self.view.bounds.width, height: 200)
        pickerView.frame = frame
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.lightGray
        view.addSubview(pickerView)
    }

    private func handlePickerShowStatus() {
        self.needToShowPicker ? self.showPicker() : self.hidePicker()
    }
    
    private func showPicker() {
        self.pickerView.dataSource = self.dataSource
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.size.height - self.pickerView.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }
    
    private func hidePicker() {
        UIView.animate(withDuration: 0.3, animations: {
            self.pickerView.frame = CGRect(x: 0, y: self.view.bounds.size.height, width: self.pickerView.bounds.size.width, height: self.pickerView.bounds.size.height)
        })
    }
}


extension CurrencyViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if let currencySource = self.pickerView.dataSource as? CurrencyPickerDataSource {
            return currencySource.currencies[row].rawValue
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let currencySource = self.pickerView.dataSource as? CurrencyPickerDataSource {
            self.currentCurrency = currencySource.currencies[row]
        }
    }
}
