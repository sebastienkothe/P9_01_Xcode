import Foundation

struct TranslateResponse: Codable {
    var data: Data
}

struct Data: Codable {
    var translations: [Translations]
}

struct Translations: Codable {
    var translatedText: String
    var detectedSourceLanguage: String
}

/*
 {
   "data": {
     "translations": [
       {
         "translatedText": "Bonjour",
         "detectedSourceLanguage": "en"
       }
     ]
   }
 }
 */
