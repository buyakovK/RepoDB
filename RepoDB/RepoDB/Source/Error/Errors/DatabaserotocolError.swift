//
//  DatabaserotocolError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaserotocolError: RepoDatabaseError {
    
    var code: Int { return 15 }
    var message: String { return ErrorLocalizer.error_code_15.localize() }
}
