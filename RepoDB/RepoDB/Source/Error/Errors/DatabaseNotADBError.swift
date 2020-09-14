//
//  DatabaseNotADBError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseNotADBError: RepoDatabaseError {
    
    var code: Int { return 26 }
    var message: String { return ErrorLocalizer.error_code_26.localize() }
}
