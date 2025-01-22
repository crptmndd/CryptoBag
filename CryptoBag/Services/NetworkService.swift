import Foundation


protocol NetworkServiceProtocol: AnyObject {
    func makeRequest(endpoint: String, method: String?, parameters: [String: Any]?, headers: [String: String]?) async throws -> (Data, HTTPURLResponse)
}


final class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(with configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    func makeRequest(endpoint: String, method: String? = "GET", parameters: [String: Any]? = nil, headers: [String: String]? = nil) async throws -> (Data, HTTPURLResponse) {
        
        guard let url = URL(string: endpoint) else { throw URLError(.badURL) }
        var request = URLRequest(url: url)
        
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let parameters = parameters {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        
        if let method = method {
            request.httpMethod = method
        }
        
        let (data, response) = try await session.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else { throw URLError(.badServerResponse) }
        
        return (data, httpResponse)
    }
    
}
