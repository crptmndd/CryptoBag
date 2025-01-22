struct CryptocurrencyResponse: Codable {
    let status: Status
    let data: [Cryptocurrency]
}

struct Status: Codable {
    let timestamp: String
    let errorCode: Int
    let errorMessage: String?
    let elapsed: Int
    let creditCount: Int
}

struct Cryptocurrency: Codable {
    let id: Int
    let name: String
    let symbol: String
    let quote: [String: Quote]
}

struct Quote: Codable {
    let price: Double
    let volume24h: Double
    let marketCap: Double
    let percentChange1h: Double
    let percentChange24h: Double
    let percentChange7d: Double
}
