//
//  Double+ColumnType.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

extension Double: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .double }
}

