//
//  NetworkError.swift
//  P9_01_Xcode
//
//  Created by Sébastien Kothé on 13/07/2020.
//  Copyright © 2020 Sébastien Kothé. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case unknownError
    case failedToDecodeJSON
    case noData
    case failedToCreateURL
    
    var title: String {
        switch self {
        case .unknownError: return "error_divide_by_zero_title"
        case .failedToDecodeJSON: return "error_add_operator_title"
        case .noData: return "error_add_equal_sign_title"
        case .failedToCreateURL: return "error_convert_math_operator_title"
        }
    }
}
