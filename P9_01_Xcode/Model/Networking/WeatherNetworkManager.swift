import Foundation

final class WeatherNetworkManager {
    
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    // MARK: - Properties
    private var networkManager: NetworkManager
    
    /// Used to get weather information for a city
    internal func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard city.trimmingCharacters(in: .whitespaces) != "" else {
            completion(.failure(.emptyTextField))
            return
        }
        
        guard let url = URLComponents.buildOpenWeatherURL(with: city) else {
            completion(.failure(NetworkError.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
    
    /// Used to get weather information based on the user's current location
    internal func fetchWeatherInformationForUserLocation(longitude: String, latitude: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        guard longitude.trimmingCharacters(in: .whitespaces) != "" || latitude.trimmingCharacters(in: .whitespaces) != "" else {
            completion(.failure(.emptyCoordinates))
            return
        }
        
        guard let url = URLComponents.buildOpenWeatherURL(longitude: longitude, latitude: latitude) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
