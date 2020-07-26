import UIKit

final class WeatherViewController: UIViewController {
    
    // MARK: - Properties
    private let weatherNetworkManager = WeatherNetworkManager()
    private let geolocalisationProvider = GeolocalisationProvider()
    
    // MARK: - Outlets
    @IBOutlet weak private var weatherSearchTextField: UITextField!
    @IBOutlet weak private var weatherSearchButton: UIButton!
    @IBOutlet weak private var weatherInformationLabel: UILabel!
    @IBOutlet weak private var weatherInformationForCurrentLocationLabel: UILabel!
}

// MARK: - Weather search
extension WeatherViewController {
    
    /// Executed when the user presses the "search" button
    @IBAction private func didTapOnSearchButton() {
        
        guard let city = weatherSearchTextField.text else { return }
        
        weatherNetworkManager.fetchWeatherInformationFor(city, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    
                    self.weatherInformationLabel.text =
                        
                    """
                    🗺 \(weatherResponse.name)\n
                    ℹ️ \(weatherDescription)\n
                    🌡 \(weatherResponse.main.temp)°
                    """
                    
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
    }
    
    /// Used to display alert messages
    private func handleError(error: NetworkError) {
        let alert = UIAlertController(title: "error_message".localized, message: error.title, preferredStyle: .alert)
        let action = UIAlertAction(title: "validation_message".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
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
    internal func didChangeLocalization(longitude: String, latitude: String) {
        weatherNetworkManager.fetchWeatherInformationForUserLocation(longitude: longitude, latitude: latitude, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    self.weatherInformationForCurrentLocationLabel.text =
                        
                    """
                    🗺 \(weatherResponse.name)\n
                    ℹ️ \(weatherDescription)\n
                    🌡 \(weatherResponse.main.temp)°
                    """
                    
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
    }
    
    @IBAction func didTapOnUpdateMyLocationButton() {
        geolocalisationProvider.getUserLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geolocalisationProvider.delegate = self
    }
}
