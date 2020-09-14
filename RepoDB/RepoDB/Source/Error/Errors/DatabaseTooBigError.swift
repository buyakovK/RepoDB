//
//  DatabaseTooBigError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseTooBigError: RepoDatabaseError {
    
    var code: Int { return 18 }
    var message: String { return ErrorLocalizer.error_code_18.localize() }
}
