import Foundation


protocol DataManagerProtocol: AnyObject {
    func fetchCyptocurrencies() async throws -> [Cryptocurrency]
}


final class DataManager: DataManagerProtocol {
    
    private let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    private let endpoint: String = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest"
    private let apiKey = "54241e99-5c96-43ec-a12d-468b6aadba9f"
    private let headers = ["X-CMC_PRO_API_KEY": apiKey]
    private let parameters = ["start": "1", "limit": "100", "convert": "USD"]
    
    private lazy var jsonDecoder: JSONDecoder = {
        JSONDecoder()
    }
    
    func fetchCyptocurrencies() async throws -> [Cryptocurrency] {
        let (data, _) = try await networkService.data(from: endpoint, method: "GET", parameters: parameters, headers: headers)
        let response: CryptoCurrenciesResponse = try jsonDecoder.decode(CryptoCurrenciesResponse.self, from: data)
        return response.data
        
        print(response.data)
    }
    
}
