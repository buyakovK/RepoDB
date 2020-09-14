//
//  TableColumn.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

@propertyWrapper
public class TableColumn<Value: ColumnTypeProtocol>: TableColumnProtocol {
    
    public var wrappedValue: Value?
    public var columnName: String
    public var nullable: Bool
    
    public init(wrappedValue: Value? = nil, name: String, nullable: Bool = false) {
        self.columnName = name
        self.wrappedValue = wrappedValue
        self.nullable = nullable
    }
    
    public func get(from row: Row) {
        if nullable {
            wrappedValue = row[columnName] as? Value
        } else {
            guard let newValue = row[columnName] as? Value else { return }
            wrappedValue = newValue
        }
    }
    
    public func save(to container: inout PersistenceContainer) {
        if nullable {
            container[columnName] = wrappedValue as? DatabaseValueConvertible
        } else {
            guard let value = wrappedValue as? DatabaseValueConvertible else { return }
            container[columnName] = value
        }
    }
    
    public func getType() -> Database.ColumnType? {
        return Value.getType()
    }
}
