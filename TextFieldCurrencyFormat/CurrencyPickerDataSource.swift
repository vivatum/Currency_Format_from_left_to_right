//
//  CurrencyPickerDelegate.swift
//  TextFieldCurrencyFormat
//
//  Created by Vivatum on 20/04/2020.
//  Copyright © 2020 vivatum. All rights reserved.
//

import UIKit

final class CurrencyPickerDataSource: NSObject, UIPickerViewDataSource {
    
    lazy var currencies: [Currency] = {
        return Currency.allCases
    }()
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencies.count
    }
}
