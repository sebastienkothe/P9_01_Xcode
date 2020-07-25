import XCTest
@testable import P9_01_Xcode

class WeatherNetworkManagerTestCase: XCTestCase {
    
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
    
    var subjectUnderTest: WeatherNetworkManager!
    
    var mockSession: MockURLSession!
    
    override func tearDown() {
        subjectUnderTest = nil
        mockSession = nil
        super.tearDown()
    }
    
    func testWeatherNetworkManager_EmptyTextField(){
        mockSession = createMockSession(fromJsonFile: "WeatherResponse", andStatusCode: 200, andError: nil)
        subjectUnderTest = WeatherNetworkManager(networkManager: NetworkManager(withSession: mockSession))
        
        subjectUnderTest.fetchWeatherInformationFor("", completion: {(result) in
            do {
                let weatherResponse = try result.get()
                XCTAssertNotNil(weatherResponse)
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.emptyTextField)
            }
        })
    }
    
    func testWeatherNetworkManager_EmptyCoordinates(){
        mockSession = createMockSession(fromJsonFile: "WeatherResponse", andStatusCode: 400, andError: nil)
        subjectUnderTest = WeatherNetworkManager(networkManager: NetworkManager(withSession: mockSession))
        
        subjectUnderTest.fetchWeatherInformationForUserLocation(longitude: "", latitude: "", completion: { (result) in
            
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNotNil(weatherResponse)
            } catch {
                XCTAssertEqual(error as? NetworkError, NetworkError.emptyCoordinates)
            }
        })
    }
}
