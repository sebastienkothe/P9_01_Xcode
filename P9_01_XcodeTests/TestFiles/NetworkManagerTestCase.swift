import XCTest
@testable import P9_01_Xcode

class NetworkManagerTestCase: XCTestCase {
    
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
    
    var subjectUnderTest: NetworkManager!
    
    var mockSession: MockURLSession!
    
    override func tearDown() {
        subjectUnderTest = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testNetworkClient_successResult() {
        mockSession = createMockSession(fromJsonFile: "CorrectData",
                                        andStatusCode: 200, andError: nil)
        subjectUnderTest = NetworkManager(withSession: mockSession)
        subjectUnderTest.fetch(url: URL(string: "TestUrl")!, completion: {(result: Result<CurrencyResponse, NetworkError>) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNotNil(currencyResponse)
                XCTAssertTrue(currencyResponse.success)
                XCTAssertTrue(currencyResponse.rates.EUR == 1)
            } catch {
                XCTAssertNil(error)
                
            }
        })
    }
    
    func testNetworkClient_404Result() {
        mockSession = createMockSession(fromJsonFile: "CorrectData", andStatusCode: 404, andError: nil)
        subjectUnderTest = NetworkManager(withSession: mockSession)
        subjectUnderTest.fetch(url: URL(string: "TestUrl")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
                XCTAssertTrue(currencyResponse.success)
                XCTAssertTrue(currencyResponse.rates.EUR == 1)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidStatusCode)
            }
        })
    }
    
    func testNetworkClient_NoData() {
        mockSession = createMockSession(fromJsonFile: "A", andStatusCode: 200, andError: nil)
        subjectUnderTest = NetworkManager(withSession: mockSession)
        subjectUnderTest.fetch(url: URL(string: "TestUrl")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.noData)
            }
        })
    }
    
    func testNetworkClient_AnotherStatusCode() {
        mockSession = createMockSession(fromJsonFile: "CorrectData", andStatusCode: 500, andError: NetworkError.unknownError)
        subjectUnderTest = NetworkManager(withSession: mockSession)
        subjectUnderTest.fetch(url: URL(string: "TestUrl")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.unknownError)
            }
        })
    }
    
    func testNetworkClient_InvalidData() {
        mockSession = createMockSession(fromJsonFile: "IncorrectData", andStatusCode: 200, andError: nil)
        subjectUnderTest = NetworkManager(withSession: mockSession)
        subjectUnderTest.fetch(url: URL(string: "TestUrl")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.failedToDecodeJSON)
            }
        })
    }
}
