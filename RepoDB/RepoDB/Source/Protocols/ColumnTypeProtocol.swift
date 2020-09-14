//
//  ColumnTypeProtocol.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

public protocol ColumnTypeProtocol {
    static func getType() -> Database.ColumnType
}
