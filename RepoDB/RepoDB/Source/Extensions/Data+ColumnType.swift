//
//  Data+ColumnType.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

extension Data: ColumnTypeProtocol {
    public static func getType() -> Database.ColumnType { return .blob }
}
