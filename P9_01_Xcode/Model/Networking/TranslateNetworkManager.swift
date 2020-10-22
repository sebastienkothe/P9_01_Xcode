import Foundation

final class TranslateNetworkManager {
    
    // MARK: - Properties
    private let networkManager: NetworkManager
    
    // Used to be able to perform dependency injection
    init(networkManager: NetworkManager = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    /// Used to retrieve information about translations
    internal func fetchTranslationInformationFor(expression: String, languageCode: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void ) {
        
        // Used to handle the case where the text field is empty
        guard expression.trimmingCharacters(in: .whitespaces) != "" else {
            completion(.failure(.emptyTextField))
            return
        }
        
        guard let url = URLComponents.buildGoogleTranslateURL(expression: expression, languageCode: languageCode) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: url, completion: completion)
    }
}
