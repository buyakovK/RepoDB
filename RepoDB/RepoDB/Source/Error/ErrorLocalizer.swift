//
//  ErrorLocalizer.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

enum ErrorLocalizer: String {
    case error_code_1
    case error_code_2
    case error_code_3
    case error_code_4
    case error_code_5
    case error_code_6
    case error_code_7
    case error_code_8
    case error_code_9
    case error_code_10
    case error_code_11
    case error_code_12
    case error_code_13
    case error_code_14
    case error_code_15
    case error_code_17
    case error_code_18
    case error_code_19
    case error_code_20
    case error_code_21
    case error_code_22
    case error_code_23
    case error_code_24
    case error_code_25
    case error_code_26
    case error_code_27
    case error_code_28
    case error_code_100
    
    func localize() -> String {
        return NSLocalizedString(self.rawValue, comment: "")
    }
}
