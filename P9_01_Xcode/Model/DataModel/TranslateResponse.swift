// Encoded data from the Google Translate API

struct TranslateResponse: Codable {
    var data: TranslationData
}

struct TranslationData: Codable {
    var translations: [Translations]
}

struct Translations: Codable {
    var translatedText: String
}
