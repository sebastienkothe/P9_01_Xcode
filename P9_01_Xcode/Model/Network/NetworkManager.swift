import Foundation

final class NetworkManager {
    
    // MARK: - Properties
    static var shared = NetworkManager()
    private init() {}
    
    private var task: URLSessionDataTask?
    private var session = URLSession(configuration: .default)
    
    init(session: URLSession) {
        self.session = session
    }
    
    /// Used to initiate a request
    internal func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        task = session.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
                else {
                    completion(.failure(.invalidStatusCode))
                    return
            }
            
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            guard let result = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.failedToDecodeJSON))
                return
            }
            
            completion(.success(result))
        }
        
        task?.resume()
    }
}
