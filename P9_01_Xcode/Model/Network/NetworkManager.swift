import Foundation

final class NetworkManager {
    
    /// Used to initiate a request
    func fetch<T: Codable>(url: URL, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        let urlSession = URLSession(configuration: .default)
        
        let task = urlSession.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(.unknownError))
                return
            }
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                200...299 ~= httpResponse.statusCode
                else { return }
            
            
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
        
        task.resume()
    }
}
