import XCTest
@testable import P9_01_Xcode

class WeatherNetworkManagerTestCase: XCTestCase {

    func testFetchWeatherInformationForShouldPostFailedCallbackIfCityIsIncorrect(){
        let weatherNetworkManager = WeatherNetworkManager()
        let expectation = XCTestExpectation(description: "wait")
        weatherNetworkManager.fetchWeatherInformationFor("Perpig", completion: {(result) in
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNil(weatherResponse)
            } catch {
                XCTAssertNotNil(error)
            }
            
            expectation.fulfill()
            
        })
        wait(for: [expectation], timeout: 50)
    }
    
    func testFetchWeatherInformationForShouldPostSucceededCallbackIfCityIsCorrect(){
        let weatherNetworkManager = WeatherNetworkManager()
        let expectation = XCTestExpectation(description: "wait")
        weatherNetworkManager.fetchWeatherInformationFor("Perpignan", completion: {(result) in
            
            do {
                let weatherResponse = try result.get()
                XCTAssertNotNil(weatherResponse)
            } catch {
                XCTAssertNil(error)
            }
            
            expectation.fulfill()
            
        })
        wait(for: [expectation], timeout: 50)
    }
}
