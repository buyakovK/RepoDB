//
//  DatabaseAbortError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseAbortError: RepoDatabaseError {
    
    var code: Int { return 4 }
    var message: String { return ErrorLocalizer.error_code_4.localize() }
}
