import Foundation

final class CurrencyNetworkManager {
    
    // MARK: - Properties
    private let networkManager = NetworkManager()
    
    /// Used to retrieve currency information
    internal func fetchInformationFor(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildFixerURL(), let currencyUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: currencyUrl, completion: completion)
    }
}
