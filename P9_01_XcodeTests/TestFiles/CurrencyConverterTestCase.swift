//
//  CurrencyConverterTestCase.swift
//  P9_01_XcodeTests
//
//  Created by Mosma on 09/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import XCTest
@testable import P9_01_Xcode

class CurrencyConverterTestCase: XCTestCase {
    
    // amount / sourceCurrency * targetCurrency
    
    var subjectUnderTest: CurrencyConverter!
    var resultConverted: String!
    
    override func setUp() {
        subjectUnderTest = CurrencyConverter()
        resultConverted = ""
    }
    
    func testCurrencyConverter_getTheConversionResult_resultConvertedMustBeEqualTo14() {
        
        resultConverted = subjectUnderTest.getTheConversionResult(sourceCurrency: 5, targetCurrency: 5, amount: 14)!
        XCTAssertEqual(resultConverted, "14")
    }
    
    func testCurrencyConverter_getTheConversionResult_resultConvertedMustBeEqualToInfiniteNumberSymbol() {
        
        resultConverted = subjectUnderTest.getTheConversionResult(sourceCurrency: 2, targetCurrency: 100000000000000001097906362944045541740492309677311846336810682903157585404911491537163328978494688899061249669721172515611590283743140088328307009198146046031271664502933027185697489699588559043338384466165001178426897626212945177628091195786707458122783970171784415105291802893207873272974885715430223118336, amount: 9)!
        XCTAssertEqual(resultConverted, "+∞")
    }
    
}
