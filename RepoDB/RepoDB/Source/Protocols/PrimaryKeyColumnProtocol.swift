//
//  PrimaryKeyColumnProtocol.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

public protocol PrimaryKeyColumnProtocol: TableColumnProtocol {
    
    var autoincremented: Bool { get set }
    
    func save(to container: inout PersistenceContainer, wiht key: String)
}
