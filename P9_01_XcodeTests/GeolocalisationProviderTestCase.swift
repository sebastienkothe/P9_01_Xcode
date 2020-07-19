import XCTest
@testable import P9_01_Xcode

class GeolocalisationProviderTestCase: XCTestCase {
    var geolocalisationProvider: GeolocalisationProvider!
    var geolocalisationProviderDelegateMock: GeolocalisationProviderDelegateMock!
    
    override func setUp() {
        geolocalisationProvider = GeolocalisationProvider()
        geolocalisationProviderDelegateMock = GeolocalisationProviderDelegateMock()
        geolocalisationProvider.delegate = geolocalisationProviderDelegateMock
    }
    
    func testIfGetUserLocationIsCalledLocationManagerShouldReturnLatitudeAndLongitudeInformation() {
        
        // Given
        geolocalisationProvider.getUserLocation()
        
        // Then
        XCTAssertNotNil(geolocalisationProviderDelegateMock.latitude)
    }
}

