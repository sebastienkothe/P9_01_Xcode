import CoreLocation

// Delegator
final class GeolocalisationProvider: NSObject, CLLocationManagerDelegate {
    
    weak internal var delegate: WeatherDelegate?
    private var locationManager: CLLocationManager?
    
    /// Used to keep geolocation disabled if longitude and latitude have the same values as in the previous search
    private var coordinates: [CLLocationDegrees]? {
        didSet {
            if
            oldValue?.first == coordinates?.first
            &&
            oldValue?.last == coordinates?.last {
                locationManager?.stopUpdatingLocation()
            } else {
                locationManager?.startUpdatingLocation()
            }
        }
    }
    
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
    
    /// Used to start geolocation
    internal func startGeolocation() {
        locationManager?.startUpdatingLocation()
    }
    
    /// Used to handle the user's current position
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let location = locations.last {
            
            coordinates?[0] = location.coordinate.latitude
            coordinates?[1] = location.coordinate.longitude
            
            // Converting coordinates to String
            let latitudeAsString = String(location.coordinate.latitude)
            let longitudeAsString = String(location.coordinate.longitude)
            
            delegate?.didChangeLocalization(longitude: longitudeAsString, latitude: latitudeAsString)
        }
    }
}
