import UIKit
import CoreLocation

final class WeatherViewController: BaseViewController {
    
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
        
        self.navigationItem.title = "navigation_item_title_weather".localized
        
        weatherSearchTextField.attributedPlaceholder = NSAttributedString(string: "Perpignan, Paris...", attributes: [NSAttributedString.Key.foregroundColor : UIColor.gray])
    }
}

// MARK: - Weather search
extension WeatherViewController {
    
    /// Executed when the user presses the "search" button
    @IBAction private func didTapOnSearchButton() {
        // To show the activity indicator and hide the button
        toggleActivityIndicator(shown: true, activityIndicator: searchAcivityIndicator, button: weatherSearchButton)
        handleTheRequestFortheSelectedCity()
    }
    
    private func handleTheRequestFortheSelectedCity() {
        guard let city = weatherSearchTextField.text else { return }
        let weatherNetworkManager = WeatherNetworkManager()
        
        weatherNetworkManager.fetchWeatherInformationFor(city, completion: { [weak self] (result) in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.searchAcivityIndicator, button: self.weatherSearchButton)
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    self.weatherInformationLabel.text = self.updateWeatherInformation(weatherResponse: weatherResponse, weatherDescription: weatherDescription)
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
            
        })
    }
    /// Used to update weather informations
    private func updateWeatherInformation(weatherResponse: WeatherResponse, weatherDescription: String) -> String {
        "🗺 \(weatherResponse.name)\nℹ️ \(weatherDescription)\n🌡 \(weatherResponse.main.temp)°"
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
        let weatherNetworkManager = WeatherNetworkManager()
        
        weatherNetworkManager.fetchWeatherInformationForUserLocation(longitude: longitude, latitude: latitude, completion: { [weak self] (result) in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.toggleActivityIndicator(shown: false, activityIndicator: self.updateLocationActivityIndicator, button: self.updateMyLocationButton)
                
                switch result {
                case .success(let weatherResponse):
                    guard let weatherDescription = weatherResponse.weather.first?.description else { return }
                    self.weatherInformationForCurrentLocationLabel.text = self.updateWeatherInformation(weatherResponse: weatherResponse, weatherDescription: weatherDescription)
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
        
        toggleActivityIndicator(shown: true, activityIndicator: updateLocationActivityIndicator, button: updateMyLocationButton)
        geolocationProvider.getUserLocation()
    }
}
