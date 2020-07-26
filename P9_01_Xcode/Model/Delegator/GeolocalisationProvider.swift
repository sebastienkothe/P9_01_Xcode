import CoreLocation

// Delegator
final class GeolocalisationProvider: NSObject, CLLocationManagerDelegate {
    
    weak internal var delegate: WeatherDelegate?
    private var locationManager: CLLocationManager?
    
    /// Used to get the user's current position
    internal func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = false
        
        locationManager?.startUpdatingLocation()
    }
    
    /// Used to handle the user's current position
    internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        // Used to stop listening for location updates
        locationManager?.stopUpdatingLocation()
        
        if let location = locations.last {
            
            // Converting coordinates to String
            let latitudeAsString = String(location.coordinate.latitude)
            let longitudeAsString = String(location.coordinate.longitude)
            
            delegate?.didChangeLocalization(longitude: longitudeAsString, latitude: latitudeAsString)
        }
    }
}
