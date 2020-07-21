import XCTest
@testable import P9_01_Xcode

class NetworkManagerTestCase: XCTestCase {
    func testFetchShouldPostFailedCallbackIfError() {
        
        // Given
        let networkManager = NetworkManager(
            session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.unknownError))
        
        // When
        networkManager.fetch(url: URL(string: "https://openclassrooms.com")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            // Then
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.unknownError)
            }
        })
    }
    
    func testFetchShouldPostFailedCallbackIfStatusCodeIsWorth500() {
        
        // Given
        let networkManager = NetworkManager(
            session: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: nil))
        
        // When
        networkManager.fetch(url: URL(string: "https://openclassrooms.com")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            // Then
            
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.invalidStatusCode)
            }
        })
    }
    
    func testFetchShouldPostFailedCallbackIfNoData() {
        
        // Given
        let networkManager = NetworkManager(
            session: URLSessionFake(data: nil, response: FakeResponseData.responseOK, error: nil))
        
        // When
        networkManager.fetch(url: URL(string: "https://openclassrooms.com")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            // Then
            
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.noData)
            }
        })
    }
    
    func testFetchShouldPostFailedCallbackIfIncorrectData() {
        
        // Given
        let networkManager = NetworkManager(
            session: URLSessionFake(data: FakeResponseData.currencyIncorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        networkManager.fetch(url: URL(string: "https://openclassrooms.com")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            // Then
            
            do {
                let currencyResponse = try result.get()
                XCTAssertNil(currencyResponse)
            } catch {
                XCTAssertEqual(error as! NetworkError, NetworkError.failedToDecodeJSON)
            }
        })
    }
    
    func testFetchShouldPostSucceededCallbackIfNoError() {
        
        // Given
        let networkManager = NetworkManager(
            session: URLSessionFake(data: FakeResponseData.currencyCorrectData, response: FakeResponseData.responseOK, error: nil))
        
        // When
        networkManager.fetch(url: URL(string: "https://openclassrooms.com")!, completion: { (result: Result<CurrencyResponse, NetworkError>) in
            // Then
            
            do {
                let currencyResponse = try result.get()
                XCTAssertNotNil(currencyResponse)
                XCTAssertNotNil(currencyResponse.rates)
                XCTAssertTrue(currencyResponse.success)
            } catch {
                XCTAssertNil(error)
            }
        })
    }
    
    func testIfDeviceLanguageIs() {
        
        let languageCode = Locale.current.languageCode
        let networkErrorCases = NetworkError.allCases
        let networkErrorTitles: [(titleEN: String, titleFR: String)] = [
            ("Unknown error", "Erreur inconnue"),
            ("Cannot decode JSON", "Impossible de décoder le JSON"),
            ("No data recovered", "Aucune donnée n'a pu en être récupéré"),
            ("Cannot create URL", "Impossible de créer l'URL"),
            ("The text field is empty!", "Le champ de texte est vide !"),
            ("Invalid status code", "Code d'état invalide"),
            ("ERROR", "ERREUR"),
            ("Alright!", "Entendu!")
        ]
        
        var i = 0
        
        for networkErrorCase in networkErrorCases {
            
            switch languageCode {
            case "en":
                XCTAssertEqual(networkErrorCase.title, networkErrorTitles[i].titleEN)
            case "fr":
                XCTAssertEqual(networkErrorCase.title, networkErrorTitles[i].titleFR)
            default:
                break
            }
            i += 1
        }
    }
}

