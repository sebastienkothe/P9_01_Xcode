enum Currency: CaseIterable {
    case BritishPoundSterling
    case Euro
    case RussianRuble
    case UnitedStatesDollar
    
    var displayName: String {
        switch self {
        
        case .BritishPoundSterling: return "British Pound Sterling"
        case .Euro: return "Euro"
        case .RussianRuble: return "Russian Ruble"
        case .UnitedStatesDollar: return "United States Dollar"
        }
    }
    
    var code: String {
        switch self {
        
        case .BritishPoundSterling: return "GBP"
        case .Euro: return "EUR"
        case .RussianRuble: return "RUB"
        case .UnitedStatesDollar: return "USD"
        }
    }
    
    var symbol: String {
        switch self {
        
        case .BritishPoundSterling: return "£"
        case .Euro: return "€"
        case .RussianRuble: return "₽"
        case .UnitedStatesDollar: return "$"
        }
    }
}


