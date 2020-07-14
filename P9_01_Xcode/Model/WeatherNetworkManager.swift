//
//  WeatherNetworkManager.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 14/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class WeatherNetworkManager {
    
    private let networkManager = NetworkManager()
    
    func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<CurrencyNetworkManager, NetworkError>) -> Void ) {
        
        let urlString = "api.openweathermap.org/data/2.5/weather?q=\(city)&appid=abfbfbe13ce1ab4e9fbd6abee671f61f"
        
        guard let weatherUrl = URL(string: urlString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        /*networkManager.fetch(url: weatherUrl, completion: completion)*/
    }
}
