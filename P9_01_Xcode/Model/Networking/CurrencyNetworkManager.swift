import Foundation

final class CurrencyNetworkManager {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    
    // Used to be able to perform dependency injection
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Used to retrieve currency information
    internal func fetchCurrencyInformation(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildFixerURL() else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
