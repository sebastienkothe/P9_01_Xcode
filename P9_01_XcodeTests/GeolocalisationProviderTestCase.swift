import XCTest
import CoreLocation
@testable import P9_01_Xcode

class GeolocalisationProviderTestCase: XCTestCase {
    var geolocalisationProvider: GeolocalisationProvider!
    var geolocalisationProviderDelegateMock: GeolocalisationProviderDelegateMock!
    
    override func setUp() {
        geolocalisationProvider = GeolocalisationProvider()
        geolocalisationProviderDelegateMock = GeolocalisationProviderDelegateMock()
        geolocalisationProvider.delegate = geolocalisationProviderDelegateMock
    }
    
    func testGivenCoordinatesAreDefined_WhenPassingThemInDidUpdateLocations_ThenLongitudeAndLatitudeMustChangeValue() {
        
        // Given
        let coordinates = [
            CLLocation(latitude: 42.69925982345143, longitude: 2.9457234900883487)
        ]
        
        // When
        geolocalisationProvider.locationManager(CLLocationManager(), didUpdateLocations: coordinates)
        
        // Then
        XCTAssertEqual(geolocalisationProviderDelegateMock.latitude, "42.69925982345143")
        XCTAssertEqual(geolocalisationProviderDelegateMock.longitude, "2.9457234900883487")
    }
}

