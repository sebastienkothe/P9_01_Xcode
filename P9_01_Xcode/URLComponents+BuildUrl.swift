import Foundation

extension URLComponents {
    
    public static func buildOpenWeatherURL(with city: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "appid", value: "abfbfbe13ce1ab4e9fbd6abee671f61f")
        ]
        return urlComponents.url
    }
    
    public static func buildOpenWeatherURL(longitude: String, latitude: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "api.openweathermap.org"
        urlComponents.path = "/data/2.5/weather"
        urlComponents.queryItems = [
            URLQueryItem(name: "lat", value: latitude),
            URLQueryItem(name: "lon", value: longitude),
            URLQueryItem(name: "appid", value: "abfbfbe13ce1ab4e9fbd6abee671f61f")
            
        ]
        return urlComponents.url
    }
    
    public static func buildGoogleTranslateURL(expression: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "AIzaSyBTIsw2XrgMIn-0Iyx_5EwbcIj0R34pAIw"),
            URLQueryItem(name: "target", value: "en"),
            URLQueryItem(name: "q", value: expression)
            
        ]
        return urlComponents.url
    }
}
