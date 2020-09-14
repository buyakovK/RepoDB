//
//  DatabasePaginationEntity.swift
//  RepoDB
//
//  Created by Groot on 13.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

public struct DatabasePaginationEntity<Entity> {
    
    var metadata: DatabaseMetadataEntity
    var entities: [Entity] = []
    
    init(page: Int, count: Int, pages: Int, entities: [Entity]) {
        self.metadata = DatabaseMetadataEntity(currentPage: page, countOnPage: count, pagesCount: pages)
        self.entities = entities
    }
    
    init(metadata: DatabaseMetadataEntity, entities: [Entity]) {
        self.metadata = metadata
        self.entities = entities
    }
}
