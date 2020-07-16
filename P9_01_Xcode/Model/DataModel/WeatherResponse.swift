//
//  WeatherResponse.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 16/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

struct WeatherResponse: Codable {
    var coord: Coordinate
    var weather: [Weather]
    var base: String
    var main: WeatherInformation
    var visibility: Int
    var wind: WindInformation
    var clouds: CloudsInformation
    var dt: Int
    var sys: SystemInformation
    var timezone: Int
    var id: Int
    var name: String
    var cod: Int
}

struct Coordinate: Codable {
    var lon: Double
    var lat: Double
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct WeatherInformation: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Int
    var humidity: Int
    
    //    enum CodingKeys: String, CodingKey {
    //        case temp = "temp"
    //        case feels_like = "feelsLike"
    //        case temp_min = "tempMin"
    //        case temp_max = "tempMax"
    //        case pressure = "pressure"
    //        case humidity = "humidity"
    //    }
}

struct WindInformation: Codable {
    var speed: Double
    var deg: Int
}

struct CloudsInformation: Codable {
    var all: Int
}

struct SystemInformation: Codable {
    var type: Int
    var id: Int
    var country: String
    var sunrise: Int
    var sunset: Int
}

