import Foundation
@testable import P9_01_Xcode

class FakeResponseData {
    
    // MARK: - Data
    static var currencyCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "Currency", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    static let currencyIncorrectData = "erreur".data(using: .utf8)!
    
    // MARK: - Response
    static let responseOK = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 200, httpVersion: nil, headerFields: [:])!
    
    static let responseKO = HTTPURLResponse(
        url: URL(string: "https://openclassrooms.com")!,
        statusCode: 500, httpVersion: nil, headerFields: [:])!
    
    // MARK: - Error
    static let unknownError = NetworkError.unknownError
    static let failedToDecodeJSON = NetworkError.failedToDecodeJSON
    static let noData = NetworkError.noData
    static let failedToCreateURL = NetworkError.failedToCreateURL
    static let emptyTextField = NetworkError.emptyTextField
}
