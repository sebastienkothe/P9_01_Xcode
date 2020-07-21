import Foundation

final class TranslateNetworkManager {
    
    // MARK: - Properties
    private let networkManager = NetworkManager.shared
    
    /// Used to retrieve information about translations
    internal func fetchTranslationInformationFor(expression: String, languageCode: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildGoogleTranslateURL(expression: expression, languageCode: languageCode), let translationUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: translationUrl, completion: completion)
    }
}
