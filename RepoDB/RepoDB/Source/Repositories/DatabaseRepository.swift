//
//  DatabaseRepository.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

public protocol DatabaseRepository {
    
    associatedtype Entity: DatabaseEntity
    
    
    func find(byId id: Int64) throws -> Entity
    func find(filterKeys: [[String: DatabaseValueConvertible?]]) throws -> Entity
    func findAll(filterKeys: [[String: DatabaseValueConvertible?]]?) throws -> [Entity]
    func save(object: Entity) throws -> Entity
    func saveAll(objects: [Entity]) throws -> [Entity]
    func update(object: Entity) throws -> Entity
    func updateAll(objects: [Entity]) throws -> [Entity]
    func delete(object: Entity) throws
    func delete(byId id: Int64) throws
    func deleteAll(objects: [Entity]) throws
    func exist(byId id: Int64) throws -> Bool
    func exist(object: Entity) throws -> Bool
    func count() throws -> Int
}

public extension DatabaseRepository {
    
    // MARK: - Find
    
    func find(byId id: Int64) throws -> Entity {
        do {
            let result = try dbQueue.read { try Entity.fetchOne($0, key: id) }
            guard let entity = result else { throw DatabaseNotFoundError() }
            return entity
        } catch {
            throw ErrorMapper.mapError(error)
        }
    }
    
    func find(filterKeys: [[String: DatabaseValueConvertible?]]) throws -> Entity {
        do {
            let result = try dbQueue.read { try Entity.filter(keys: filterKeys).fetchOne($0) }
            guard let entity = result else { throw DatabaseNotFoundError() }
            return entity
        } catch {
            throw ErrorMapper.mapError(error)
        }
    }
    
    func findAll(filterKeys: [[String: DatabaseValueConvertible?]]? = nil) throws -> [Entity] {
        do {
            let result = filterKeys == nil ?
                (try dbQueue.read { try Entity.fetchAll($0) }) :
                (try dbQueue.read { try Entity.filter(keys: filterKeys.unsafelyUnwrapped).fetchAll($0) })
            return result
        } catch {
            throw ErrorMapper.mapError(error)
        }
    }
    
    // MARK: - Save
    
    func save(object: Entity) throws -> Entity {
        var entity = object
        do {
            try dbQueue.inDatabase { try entity.insert($0) }
        } catch {
            throw ErrorMapper.mapError(error)
        }
        return entity
    }
    
    func saveAll(objects: [Entity]) throws -> [Entity] {
        var entities: [Entity] = []
        try objects.forEach { object in
            do {
                entities.append(try self.save(object: object))
            } catch {
                throw ErrorMapper.mapError(error)
            }
        }
        return entities
    }
    
    // MARK: - Update
    
    func update(object: Entity) throws -> Entity {
        do {
            try dbQueue.inDatabase { try object.update($0) }
        } catch {
            throw ErrorMapper.mapError(error)
        }
        return object
    }
    
    func updateAll(objects: [Entity]) throws -> [Entity] {
        var entities: [Entity] = []
        try objects.forEach({ object in
            do {
                entities.append(try self.update(object: object))
            } catch {
                throw ErrorMapper.mapError(error)
            }
        })
        return entities
    }
    
    // MARK: - Delete
    
    func delete(byId id: Int64) throws {
        do {
            _ = try dbQueue.inDatabase { try Entity.deleteOne($0, key: id) }
        } catch {
            throw ErrorMapper.mapError(error)
        }
    }
    
    func delete(object: Entity) throws {
        guard let id = object.id else { throw DatabaseNoSlfError() }
        do {
            try self.delete(byId: id)
        } catch {
            throw ErrorMapper.mapError(error)
        }
    }
    
    func deleteAll(objects: [Entity]) throws {
        try objects.forEach({ object in
            do {
                try self.delete(object: object)
            } catch {
                throw ErrorMapper.mapError(error)
            }
        })
    }
    
    // MARK: - Exist
    
    func exist(object: Entity) throws -> Bool {
        var isExist = false
        do {
            try dbQueue.read { isExist = try object.exists($0) }
        } catch {
            throw ErrorMapper.mapError(error)
        }
        return isExist
    }
    
    func exist(byId id: Int64) throws -> Bool {
        var isExist = false
        do {
            let object = try self.find(byId: id)
            isExist = try self.exist(object: object)
        } catch {
            throw ErrorMapper.mapError(error)
        }
        return isExist
    }
    
    // MARK: - Count
    
    func count() throws -> Int {
        var count = 0
        do {
            try dbQueue.read { count = try Entity.fetchCount($0) }
        } catch {
            throw ErrorMapper.mapError(error)
        }
        return count
    }
}
