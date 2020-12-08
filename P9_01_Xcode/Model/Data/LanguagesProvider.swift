enum Language: CaseIterable {
    case Français
    case Allemand
    case Anglais
    case Arabe
    case Afrikaans
    
    var displayName: String {
        switch self {
        
        case .Français: return "Français"
        case .Afrikaans: return "Afrikaans"
        case .Allemand: return "Allemand"
        case .Anglais: return "Anglais"
        case .Arabe: return "Arabe"
        }
    }
    
    var code: String {
        switch self {
        
        case .Français: return "fr"
        case .Afrikaans: return "af"
        case .Allemand: return "de"
        case .Anglais: return "en"
        case .Arabe: return "ar"
        }
    }
}
