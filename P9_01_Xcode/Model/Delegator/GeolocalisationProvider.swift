import CoreLocation

// Delegator
final class GeolocalisationProvider: NSObject, CLLocationManagerDelegate {
    
    weak internal var delegate: WeatherDelegate?
    private var locationManager: CLLocationManager?
    
    /// Used to get the user's current position
    internal func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    /// Used to stop geolocation
    internal func stopGeolocation() {
        locationManager?.stopUpdatingLocation()
    }
    
    /// Used to handle the user's current position
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            // Converting coordinates to String
            let latitudeAsString = String(location.coordinate.latitude)
            let longitudeAsString = String(location.coordinate.longitude)
            
            delegate?.didChangeLocalization(longitude: longitudeAsString, latitude: latitudeAsString)
        }
    }
}
