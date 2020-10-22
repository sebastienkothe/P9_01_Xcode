import XCTest
@testable import P9_01_Xcode

class NetworkErrorTestCase: XCTestCase {
    
    func testGivenDeviceLanguageIsFrOrEn_WhenTryingToAccessAtTheTitleOfTheNetworkErrorCase_ThenCorrectStringShouldReturn() {
        
        let languageCode = Locale.current.languageCode
        let networkErrorCases = NetworkError.allCases
        let networkErrorTitles: [(titleEN: String, titleFR: String)] = [
            ("Unknown error", "Erreur inconnue"),
            ("Cannot decode JSON", "Impossible de décoder le JSON"),
            ("No data recovered", "Aucune donnée n'a pu en être récupéré"),
            ("Cannot create URL", "Impossible de créer l'URL"),
            ("The text field is empty!", "Le champ de texte est vide !"),
            ("Incorrect http response code", "Code de réponse http incorrect"),
            ("The location service is disabled", "Le service de localisation est désactivé"),
            ("ERROR", "ERREUR"),
            ("Alright!", "Entendu!")
        ]
        
        var i = 0
        
        for networkErrorCase in networkErrorCases {
            
            switch languageCode {
            case "en":
                XCTAssertEqual(networkErrorCase.title, networkErrorTitles[i].titleEN)
            case "fr":
                XCTAssertEqual(networkErrorCase.title, networkErrorTitles[i].titleFR)
            default:
                break
            }
            i += 1
        }
    }
}
