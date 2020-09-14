//
//  DatabaseBusyError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseBusyError: RepoDatabaseError {
    
    var code: Int { return 5 }
    var message: String { return ErrorLocalizer.error_code_5.localize() }
}
