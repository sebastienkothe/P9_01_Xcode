import Foundation

final class NetworkManager {
    
    // MARK: - Properties
    private var session: URLSessionProtocol
    
     // The default session value is URLSession.shared.
     // Any class that adopts the URLSessionProtocol can replace URLSession.shared.
    init(withSession session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    /// Used to initiate a request
    internal func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
                else {
                    completion(.failure(.incorrectHttpResponseCode))
                    return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
            completion(.success(result))
        }
        
        task.resume()
    }
}
