//
//  TranslateUrlProviderProtocol.swift
//  P9_01_Xcode
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

protocol TranslateUrlProviderProtocol {
    func buildGoogleTranslateUrl(expression: String, languageCode: String) -> URL?
}
