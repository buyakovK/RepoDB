//
//  DatabaseNotIceError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

struct DatabaseNotIceError: RepoDatabaseError {
    
    var code: Int { return 27 }
    var message: String { return ErrorLocalizer.error_code_27.localize() }
}
