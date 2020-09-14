//
//  DatabasePaginationRepository.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

public protocol DatabasePaginationRepository: DatabaseRepository {
    
    func findAll(page: Int, count: Int) throws -> DatabasePaginationEntity<Entity>
}

extension DatabasePaginationRepository {
    
    func findAll(page: Int, count: Int) throws -> DatabasePaginationEntity<Entity> {
        var result: DatabasePaginationEntity<Entity>?
        do {
            let entities = try dbQueue.read {
                try Entity
                    .limit(count, offset: page * count)
                    .fetchAll($0)
            }
            let objectsCount = try dbQueue.read { try Entity.fetchCount($0) }
            let pagesCount = objectsCount % count == 0 ? (objectsCount/count) : (objectsCount/count + 1)
            let metadata = DatabaseMetadataEntity(currentPage: page, countOnPage: count, pagesCount: pagesCount)
            result = DatabasePaginationEntity(metadata: metadata, entities: entities)
        } catch {
            throw ErrorMapper.mapError(error)
        }
        guard let dbMetaDataEntity = result else { throw DatabaseNotFoundError() }
        return dbMetaDataEntity
    }
}
