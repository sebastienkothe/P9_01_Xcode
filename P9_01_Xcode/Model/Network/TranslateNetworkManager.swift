import Foundation

final class TranslateNetworkManager {
    private let networkManager = NetworkManager()
    
    func fetchTranslationInformationFor(expression: String, completion: @escaping (Result<TranslateResponse, NetworkError>) -> Void ) {
        
        guard let url = URLComponents.buildGoogleTranslateURL(expression: expression), let translationUrl = URL(string: url.absoluteString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        networkManager.fetch(url: translationUrl, completion: completion)
    }
}
