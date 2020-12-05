//
//  CurrencyUrlProviderProtocol.swift
//  P9_01_Xcode
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

protocol CurrencyUrlProviderProtocol {
    func buildFixerUrl() -> URL?
}
