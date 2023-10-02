import Foundation

final class NetwokingRequest {
    
    static func load<T: Codable>(_ resource: Resource<T>, completion: @escaping (Result<(statusCode: Int, dataDecoder: T?), Error>) -> ()) {
        
        var request = URLRequest(url: resource.url)
        
        switch resource.method {
        case .post(let data):
            request.httpMethod = resource.method.name
            request.httpBody = data
        case .get(let queryItems):
            var components = URLComponents(url: resource.url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                return completion(.failure(NetworkError.badUrl))
            }
            request = URLRequest(url: url)
        }
        
        // create the URLSession configuration
        let configuration = URLSessionConfiguration.default
        // add default headers
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse, Set(200 ... 208).contains(httpResponse.statusCode) else {
                return completion(.failure(NetworkError.invalidResponse))
            }
            
            guard let data = data else {
                return completion(.success((statusCode: httpResponse.statusCode, dataDecoder: nil)))
            }
            
            guard let dataDecoder = try? JSONDecoder().decode(T.self, from: data) else {
                return completion(.failure(NetworkError.decodingError))
            }
            
            return completion(Result.success((statusCode: httpResponse.statusCode, dataDecoder: dataDecoder)))
        }
    }
}
