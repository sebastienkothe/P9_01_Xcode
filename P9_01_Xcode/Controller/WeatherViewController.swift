import UIKit
import CoreLocation

final class WeatherViewController: RootController {
    
    // MARK: - Properties
    private let geolocationProvider = GeolocationProvider()
    
    // MARK: - Outlets
    @IBOutlet weak private var weatherSearchTextField: UITextField!
    @IBOutlet weak private var weatherSearchButton: UIButton!
    @IBOutlet weak var updateMyLocationButton: UIButton!
    @IBOutlet weak private var weatherInformationLabel: UILabel!
    @IBOutlet weak private var weatherInformationForCurrentLocationLabel: UILabel!
    @IBOutlet weak var searchAcivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var updateLocationActivityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geolocationProvider.delegate = self
        
        // Default values for the interface
        searchAcivityIndicator.isHidden = true
        updateLocationActivityIndicator.isHidden = true
        weatherSearchButton.layer.cornerRadius = 30
        updateMyLocationButton.layer.cornerRadius = 30
    }
}

// MARK: - Weather search
extension WeatherViewController {
    
    /// Executed when the user presses the "search" button
    @IBAction private func didTapOnSearchButton() {
        
        let weatherNetworkManager = WeatherNetworkManager()
        
        guard let city = weatherSearchTextField.text else { return }
        
        // To show the activity indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: searchAcivityIndicator, button: weatherSearchButton)
        
        weatherNetworkManager.fetchWeatherInformationFor(city, completion: {(result) in
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.searchAcivityIndicator, button: self.weatherSearchButton)
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    
                    self.weatherInformationLabel.text =
                        
                        """
                    🗺 \(weatherResponse.name)
                    ℹ️ \(weatherDescription)
                    🌡 \(weatherResponse.main.temp)°
                    """
                    
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
    }
}

// MARK: - Keyboard
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction private func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        weatherSearchTextField.resignFirstResponder()
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == weatherSearchTextField {
            
            // Used to dismiss your keyboard
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Localization
extension WeatherViewController: WeatherDelegate {
    internal func didChangeLocation(longitude: String, latitude: String) {
        
        // To avoid the retain cycle
        let weatherNetworkManager = WeatherNetworkManager()
        
        toggleActivityIndicator(shown: true, activityIndicator: updateLocationActivityIndicator, button: updateMyLocationButton)
        
        weatherNetworkManager.fetchWeatherInformationForUserLocation(longitude: longitude, latitude: latitude, completion: {(result) in
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.updateLocationActivityIndicator, button: self.updateMyLocationButton)
                
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    self.weatherInformationForCurrentLocationLabel.text =
                        
                        """
                    🗺 \(weatherResponse.name)
                    ℹ️ \(weatherDescription)
                    🌡 \(weatherResponse.main.temp)°
                    """
                    
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
    }
    
    @IBAction func didTapOnUpdateMyLocationButton() {
        
        // Used to manage devices that have location service disabled or non-existent
        guard CLLocationManager.locationServicesEnabled() else {
            handleError(error: .locationServiceDisabled)
            return
        }
        
        geolocationProvider.getUserLocation()
    }
}
