//
//  RepoDatabaseError.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

public protocol RepoDatabaseError: Error {
    
    var code: Int { get }
    var message: String { get }
}
