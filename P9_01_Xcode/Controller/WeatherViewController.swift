//
//  WeatherViewController.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 13/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var weatherSearchTextField: UITextField!
    @IBOutlet weak var weatherSearchButton: UIButton!
    @IBOutlet weak var weatherInformationLabel: UILabel!
    @IBOutlet weak var weatherInformationForCurrentLocationLabel: UILabel!
    
    private let weatherNetworkManager = WeatherNetworkManager()
    private var locationManager:CLLocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getUserLocation()
        
    }
    
    @IBAction func didTapOnSearchButton() {
        
        guard let city = weatherSearchTextField.text else {
            return
        }
        
        weatherNetworkManager.fetchWeatherInformationFor(city, completion: {(result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let weatherResponse):
                    self.weatherInformationLabel.text = "\(weatherResponse.name)"
                case .failure(let error):
                    self.handleError(error: error)
                }
            }
        })
    }
    
    /// Used to display alert messages
    func handleError(error: NetworkError) {
        let alert = UIAlertController(title: "error_message".localized, message: error.title, preferredStyle: .alert)
        let action = UIAlertAction(title: "validation_message".localized, style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    /// Used to get the user's current position
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.startUpdatingLocation()
        locationManager?.delegate = self
    }
    
    /// Used to handle the user's current position
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            weatherInformationLabel.text = "Lat : \(location.coordinate.latitude) \nLng : \(location.coordinate.longitude)"
            
            weatherNetworkManager.fetchWeatherInformationForUserLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, completion: {(result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let weatherResponse):
                        self.weatherInformationForCurrentLocationLabel.text = "\(weatherResponse.name)"
                    case .failure(let error):
                        self.handleError(error: error)
                    }
                }
            })
        }
    }
}

// MARK: - Keyboard
extension WeatherViewController: UITextFieldDelegate {
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        weatherSearchTextField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == weatherSearchTextField {
            //any task to perform
            textField.resignFirstResponder() //if you want to dismiss your keyboard
        }
        return true
    }
}


