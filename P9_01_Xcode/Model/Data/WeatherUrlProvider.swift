//
//  WeatherUrlProvider.swift
//  P9_01_Xcode
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class WeatherUrlProvider: WeatherUrlProviderProtocol {
    func buildOpenWeatherURL(with city: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: "abfbfbe13ce1ab4e9fbd6abee671f61f"),
            URLQueryItem(name: "units", value: "metric")
        ]
        return urlComponents.url
    }
    
    func buildOpenWeatherUrl(longitude: String, latitude: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: "abfbfbe13ce1ab4e9fbd6abee671f61f"),
            URLQueryItem(name: "units", value: "metric")
            
        ]
        return urlComponents.url
    }
}
