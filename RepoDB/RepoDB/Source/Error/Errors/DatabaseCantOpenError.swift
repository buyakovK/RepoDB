//
//  DatabaseCantOpenError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseCantOpenError: RepoDatabaseError {
    
    var code: Int { 14 }
    var message: String { ErrorLocalizer.error_code_14.localize() }
}
