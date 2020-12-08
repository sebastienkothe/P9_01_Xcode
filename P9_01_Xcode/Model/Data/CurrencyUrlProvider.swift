//
//  CurrencyUrlProvider.swift
//  P9_01_Xcode
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class CurrencyUrlProvider: CurrencyUrlProviderProtocol {
    
    func buildFixerUrl() -> URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "http"
        urlComponents.host = "data.fixer.io"
        urlComponents.path = "/api/latest"
        urlComponents.queryItems = [
            URLQueryItem(name: "access_key", value: "60f39633face57ab2d771ead1c0baad8"),
        ]
        return urlComponents.url
    }
}
