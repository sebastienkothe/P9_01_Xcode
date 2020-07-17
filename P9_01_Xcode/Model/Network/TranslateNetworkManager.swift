import Foundation

final class TranslateNetworkManager {
    private let networkManager = NetworkManager()
    
    func fetchTranslationInformationFor(expression: String, languageCode: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildGoogleTranslateURL(expression: expression, languageCode: languageCode), let translationUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: translationUrl, completion: completion)
    }
}
