//
//  CurrencyConverter.swift
//  P9_01_Xcode
//
//  Created by Fanny BANTREIL on 29/11/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class CurrencyConverter {
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.alwaysShowsDecimalSeparator = false
        return numberFormatter
    }()
    
    /// Used to get the result of the conversion
    func getTheConversionResult(sourceCurrency: Double, targetCurrency: Double, amount: Double) -> String? {
        var result: Double
        
        result = amount / sourceCurrency * targetCurrency
        return formatTheConversionResult(result)
    }
    
    /// Used to format the result of the conversion
    private func formatTheConversionResult(_ result: Double) -> String? {
        let resultAsNSNumber = NSNumber(value: result)
        let formattedResultAsString = numberFormatter.string(from: resultAsNSNumber)
        return formattedResultAsString
    }
}
