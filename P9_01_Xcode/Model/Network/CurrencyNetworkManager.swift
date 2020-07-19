import Foundation

final class CurrencyNetworkManager {
    private let networkManager = NetworkManager()
    
    internal func fetchInformationFor(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildFixerURL(), let currencyUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: currencyUrl, completion: completion)
    }
}
