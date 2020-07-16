//
//  String+Localized.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 16/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
