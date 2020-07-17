import Foundation

final class WeatherNetworkManager {
    
    private let networkManager = NetworkManager()
    
    /// Used to get weather information for a city
    func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URLComponents.buildOpenWeatherURL(with: city), let weatherUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
    
    /// Used to get weather information based on the user's current location
    func fetchWeatherInformationForUserLocation(longitude: String, latitude: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URLComponents.buildOpenWeatherURL(longitude: longitude, latitude: latitude), let weatherUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
}
