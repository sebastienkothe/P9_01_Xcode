//
//  WeatherNetworkManager.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 14/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation
import CoreLocation

class WeatherNetworkManager {
    
    private let networkManager = NetworkManager()
    
    /// Used to get weather information for a city
    func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void ) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?q=\(city)&appid=abfbfbe13ce1ab4e9fbd6abee671f61f"
        
        guard let weatherUrl = URL(string: urlString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
    
    /// Used to get weather information based on the user's current location
    func fetchWeatherInformationForUserLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=abfbfbe13ce1ab4e9fbd6abee671f61f"
        
        guard let weatherUrl = URL(string: urlString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
}
