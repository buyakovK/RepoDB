//
//  UInt+ColumnType.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

extension UInt: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension UInt8: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension UInt16: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension UInt32: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}

extension UInt64: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .integer }
}
