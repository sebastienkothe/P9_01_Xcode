// Encoded data from the fixer.io API

struct CurrencyResponse: Codable {
    var success: Bool
    var rates: [String: Double]
}
