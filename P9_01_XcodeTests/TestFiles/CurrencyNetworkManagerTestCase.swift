//
//  CurrencyNetworkManagerTestCase.swift
//  P9_01_XcodeTests
//
//  Created by Sébastien Kothé on 26/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import XCTest
@testable import P9_01_Xcode

class CurrencyNetworkManagerTestCase: XCTestCase {
    private func loadJsonData(file: String) -> Data? {
        if let jsonFilePath = Bundle(for: type(of: self)).path(forResource: file, ofType: "json") {
            let jsonFileURL = URL(fileURLWithPath: jsonFilePath)
            if let jsonData = try? Data(contentsOf: jsonFileURL) {
                return jsonData
            }
        }
        return nil
    }
    
    private func createMockSession(fromJsonFile file: String, andStatusCode code: Int, andError error: Error?) -> MockURLSession? {
        let data = loadJsonData(file: file)
        
        let response = HTTPURLResponse(url: URL(string: "TestUrl")!, statusCode: code, httpVersion: nil, headerFields: nil)
        
        return MockURLSession(completionHandler: (data, response, error))
    }
    
    var subjectUnderTest: CurrencyNetworkManager!
    
    var mockSession: MockURLSession!
    
    override func tearDown() {
        subjectUnderTest = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testCurrencyNetworkManager_SuccessResult() {
        mockSession = createMockSession(fromJsonFile: "CurrencyResponse", andStatusCode: 200, andError: nil)
        subjectUnderTest = CurrencyNetworkManager(networkManager: NetworkManager(withSession: mockSession))
        
        subjectUnderTest.fetchCurrencyInformation(completion: { (result) in
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNotNil(weatherResponse)
            } catch {
                XCTAssertNil(error)
            }
        })
    }
    
    func testCurrencyNetworkManager_fetchCurrencyInformation_buildFixerUrlMustReturnNil() {
        mockSession = createMockSession(fromJsonFile: "CurrencyResponse", andStatusCode: 200, andError: nil)
        subjectUnderTest = CurrencyNetworkManager(networkManager: NetworkManager(withSession: mockSession), currencyUrlProvider: CurrencyUrlProviderMock())
        
        subjectUnderTest.fetchCurrencyInformation(completion: {(result) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.failedToCreateURL)
            }
        })
    }
    
}
