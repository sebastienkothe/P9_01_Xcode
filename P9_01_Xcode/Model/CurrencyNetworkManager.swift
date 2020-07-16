//
//  CurrencyNetworkManager.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 14/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

class CurrencyNetworkManager {
    private let networkManager = NetworkManager()
    
    func fetchInformationFor(_ currency: String, completion: @escaping (Result<CurrencyResponse, NetworkError>) -> Void ) {
        
        let urlString = "https://api.exchangeratesapi.io/latest?base=\(currency)"
        
        guard let currencyUrl = URL(string: urlString) else {
            completion(.failure(.failedToCreateURL))
            return
        }
        
        /*networkManager.fetch(url: currencyUrl, completion: completion)*/
    }
}
