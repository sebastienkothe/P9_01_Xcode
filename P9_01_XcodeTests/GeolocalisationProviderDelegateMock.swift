@testable import P9_01_Xcode

class GeolocalisationProviderDelegateMock: WeatherDelegate {
    
    var latitude: String?
    var longitude: String?
    
    func didChangeLocalization(longitude: String, latitude: String) {
        self.longitude = longitude
        self.latitude = latitude
    }
}
