//
//  TranslateUrlProvider.swift
//  P9_01_Xcode
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class TranslateUrlProvider: TranslateUrlProviderProtocol {
    func buildGoogleTranslateUrl(expression: String, languageCode: String) -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "translation.googleapis.com"
        urlComponents.path = "/language/translate/v2"
        urlComponents.queryItems = [
            URLQueryItem(name: "key", value: "AIzaSyBTIsw2XrgMIn-0Iyx_5EwbcIj0R34pAIw"),
            URLQueryItem(name: "target", value: languageCode),
            URLQueryItem(name: "q", value: expression)
            
        ]
        return urlComponents.url
    }
}
