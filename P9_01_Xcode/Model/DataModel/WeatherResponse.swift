// Encoded data from the OpenWeathermap API

struct WeatherResponse: Codable {
    var weather: [Weather]
    var main: WeatherInformation
    var name: String
}

struct Weather: Codable {
    var description: String
}

struct WeatherInformation: Codable {
    var temp: Double
}
