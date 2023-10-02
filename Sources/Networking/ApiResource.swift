import Foundation

enum NetworkError: Error {
    case invalidResponse
    case badUrl
    case decodingError
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}


struct Resource<T: Codable> {
    let url: URL
    var method: HttpMethod = .get([])
}

