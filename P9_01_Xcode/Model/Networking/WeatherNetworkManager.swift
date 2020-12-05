import Foundation

final class WeatherNetworkManager {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let weatherUrlProvider: WeatherUrlProviderProtocol
    
    // Used to be able to perform dependency injection
    init(
        networkManager: NetworkManager = NetworkManager(),
        weatherUrlProvider: WeatherUrlProviderProtocol = WeatherUrlProvider()
    ) {
        self.networkManager = networkManager
        self.weatherUrlProvider = weatherUrlProvider
    }
    
    /// Used to get weather information for a city
    internal func fetchWeatherInformationFor(_ city: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
        
        // Used to handle the case where the text field is empty
        guard city.trimmingCharacters(in: .whitespaces) != "" else {
            completion(.failure(.emptyTextField))
            return
        }
        
        guard let url = weatherUrlProvider.buildOpenWeatherURL(with: city) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
    
    /// Used to get weather information based on the user's current location
    internal func fetchWeatherInformationForUserLocation(longitude: String, latitude: String, completion: @escaping (Result<WeatherResponse, NetworkError>) -> Void) {
    
        guard let url = weatherUrlProvider.buildOpenWeatherUrl(longitude: longitude, latitude: latitude) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
