//
//  StringExtension.swift
//  TextFieldCurrencyFormat
//
//  Created by Vivatum on 20/04/2020.
//  Copyright © 2020 vivatum. All rights reserved.
//

import Foundation

extension String {
    
    // formatting text for currency textField
    func currencyInputFormatting(_ currency: Currency) -> String {
        
        let emptyString = ""
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "es_CL")
        formatter.currencySymbol = currency.rawValue
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        
        var amountWithPrefix = self
        
        // clear String: "$", ".", ","
        
        do {
            let regex = try NSRegularExpression(pattern: "[^0-9]", options: .caseInsensitive)
            amountWithPrefix = regex.stringByReplacingMatches(in: amountWithPrefix, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count), withTemplate: emptyString)
        } catch let error {
            NSLog("RegEx Error: \(error.localizedDescription)")
            return emptyString
        }
        
        guard let double = Double(amountWithPrefix) else { return emptyString }
        let number = NSNumber(value: (double / 100))

        // if first number is 0 or all numbers were deleted
        guard number != 0 as NSNumber else {
            return emptyString
        }
        
        return formatter.string(from: number) ?? emptyString
    }
}
