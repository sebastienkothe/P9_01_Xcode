//
//  TranslateNetworkManager.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 14/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class TranslateNetworkManager {
    private let networkManager = NetworkManager()
    
    func fetchTranslationInformationFor(_ word: String, sourceLanguage: String, targetLanguage: String, completion: @escaping (Result<CurrencyNetworkManager, NetworkError>) -> Void ) {
        
        let urlString = "https://api.mymemory.translated.net/get?q=\(word)&langpair=\(sourceLanguage)|\(targetLanguage)"
        
        guard let translateUrl = URL(string: urlString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        /*networkManager.fetch(url: translateUrl, completion: completion)*/
    }
}
