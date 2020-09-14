//
//  DatabasePermissionError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabasePermissionError: RepoDatabaseError {
    
    var code: Int { return 3 }
    var message: String { return ErrorLocalizer.error_code_3.localize() }
}
