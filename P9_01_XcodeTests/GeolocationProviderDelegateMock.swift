@testable import P9_01_Xcode

class GeolocationProviderDelegateMock: WeatherDelegate {
    
    var latitude: String?
    var longitude: String?
    
    func didChangeLocation(longitude: String, latitude: String) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
