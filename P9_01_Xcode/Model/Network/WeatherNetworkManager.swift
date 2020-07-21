import Foundation

final class WeatherNetworkManager {
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    
    /// Used to get weather information for a city
    internal func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URLComponents.buildOpenWeatherURL(with: city), let weatherUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
    
    /// Used to get weather information based on the user's current location
    internal func fetchWeatherInformationForUserLocation(longitude: String, latitude: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard let url = URLComponents.buildOpenWeatherURL(longitude: longitude, latitude: latitude), let weatherUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: weatherUrl, completion: completion)
    }
}
