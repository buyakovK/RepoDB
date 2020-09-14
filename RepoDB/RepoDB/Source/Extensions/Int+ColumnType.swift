//
//  Int+ColumnType.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

extension Int: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension Int8: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension Int16: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension Int32: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension Int64: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}
