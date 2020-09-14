//
//  DatabaseEntity.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

public protocol DatabaseEntity: FetchableRecord, MutablePersistableRecord  {
    
    var id: Int64? { get set }
    init()
}

extension DatabaseEntity {
    
    init(row: Row) {
        self.init()
        Mirror(reflecting: self).children.forEach { child in
            guard let tableColumn = child.value as? TableColumnProtocol else { return }
            tableColumn.get(from: row)
        }
    }
    
    func encode(to container: inout PersistenceContainer) {
        Mirror(reflecting: self).children.forEach { child in
            guard let tableColumn = child.value as? TableColumnProtocol else { return }
            tableColumn.save(to: &container)
        }
    }
}

extension DatabaseEntity {
    
    mutating func didInsert(with rowID: Int64, for column: String?) {
        self.id = rowID
    }
    
    static func orderedById() -> QueryInterfaceRequest<Self> {
        return order(Column("id"))
    }
}
