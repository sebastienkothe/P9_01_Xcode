//
//  String+Extensions.swift
//  P9_01_Xcode
//
//  Created by Fanny BANTREIL on 29/10/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

extension String {
    
    /// Used to return the correct value in the device language
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
}
