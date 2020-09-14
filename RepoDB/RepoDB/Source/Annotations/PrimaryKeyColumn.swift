//
//  PrimaryKeyColumn.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

@propertyWrapper
public class PrimaryKeyColumn<Value: ColumnTypeProtocol>: TableColumn<Value>, PrimaryKeyColumnProtocol {
    
    public var autoincremented: Bool
    
    public override var wrappedValue: Value? {
        get { return super.wrappedValue }
        set { super.wrappedValue = newValue }
    }
    
    public init(wrappedValue: Value? = nil, name: String, autoincremented: Bool = true) {
        self.autoincremented = autoincremented
        super.init(wrappedValue: wrappedValue, name: name, nullable: false)
    }
    
    public func save(to container: inout PersistenceContainer, wiht key: String) {
        container[key] = wrappedValue as? DatabaseValueConvertible
    }
    
}
