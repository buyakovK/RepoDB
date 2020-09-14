//
//  TableColumnProtocol.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

public protocol TableColumnProtocol {
    
    var columnName: String { get set }
    var nullable: Bool { get set }
    
    func get(from row: Row)
    func save(to container: inout PersistenceContainer)
    func getType() -> Database.ColumnType?
}
