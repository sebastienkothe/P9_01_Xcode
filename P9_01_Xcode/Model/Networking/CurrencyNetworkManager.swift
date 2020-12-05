import Foundation

final class CurrencyNetworkManager {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    private let currencyUrlProvider: CurrencyUrlProviderProtocol
    
    // Used to be able to perform dependency injection
    init(
        networkManager: NetworkManager = NetworkManager(),
        currencyUrlProvider: CurrencyUrlProviderProtocol = CurrencyUrlProvider()
    ) {
        self.networkManager = networkManager
        self.currencyUrlProvider = currencyUrlProvider
    }
    
    /// Used to retrieve currency information
    internal func fetchCurrencyInformation(completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void ) {
        
        guard let url = currencyUrlProvider.buildFixerUrl() else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
