// Encoded data from the fixer.io API

struct CurrencyResponse: Codable {
    var success: Bool
    var rates: Rates
}

struct Rates: Codable, PropertyReflectable {
    var GBP: Double
    var EUR: Double
    var RUB: Double
    var USD: Double
}
