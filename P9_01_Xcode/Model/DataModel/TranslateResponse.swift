struct TranslateResponse: Codable {
    var data: TranslationData
}

struct TranslationData: Codable {
    var translations: [Translations]
}

struct Translations: Codable {
    var translatedText: String
    var detectedSourceLanguage: String
}
