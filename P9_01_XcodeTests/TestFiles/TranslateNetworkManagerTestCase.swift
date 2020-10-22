//
//  TranslateNetworkManagerTestCase.swift
//  P9_01_XcodeTests
//
//  Created by Sébastien Kothé on 26/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import XCTest
@testable import P9_01_Xcode

class TranslateNetworkManagerTestCase: XCTestCase {
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
    
    var subjectUnderTest: TranslateNetworkManager!
    
    var mockSession: MockURLSession!
    
    override func tearDown() {
        subjectUnderTest = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testTranslateNetworkManager_SuccessResult() {
        mockSession = createMockSession(fromJsonFile: "TranslateResponse", andStatusCode: 200, andError: nil)
        subjectUnderTest = TranslateNetworkManager(networkManager: NetworkManager(withSession: mockSession))
        
        subjectUnderTest.fetchTranslationInformationFor(expression: "Hello", languageCode: "fr", completion: { (result) in
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNotNil(weatherResponse)
            } catch {
                XCTAssertNil(error)
            }
        })
    }
    
    func testTranslateNetworkManager_EmptyTextField() {
        mockSession = createMockSession(fromJsonFile: "TranslateResponse", andStatusCode: 400, andError: nil)
        subjectUnderTest = TranslateNetworkManager(networkManager: NetworkManager(withSession: mockSession))
        
        subjectUnderTest.fetchTranslationInformationFor(expression: "", languageCode: "fr", completion: { (result) in
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNil(weatherResponse)
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.emptyTextField)
            }
        })
    }
    
}
