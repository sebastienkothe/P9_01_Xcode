//
//  CurrencyUrlProviderMock.swift
//  P9_01_XcodeTests
//
//  Created by Mosma on 04/12/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation
@testable import P9_01_Xcode

class CurrencyUrlProviderMock: CurrencyUrlProviderProtocol {
    func buildFixerUrl() -> URL? {
        return nil
    }
}
