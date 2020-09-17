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
    
    /// Returns the entity of the database by id.
    ///
    ///     let object = try? repository.find(byId: 1)
    ///
    /// - parameter byId: Object id in the database.
    /// - throws: Exception handler.
    func find(byId id: Int64) throws -> Entity
    
    
    /// Returns the database entity for the given field values.
    ///
    ///     let object = try? repository.find(filterKeys: [["id": "1"], ["text": "Test"]])
    ///
    /// - parameter filterKeys: A dictionary of keys and values by which the entity is searched in the database.
    /// - throws: Exception handler.
    func find(filterKeys: [[String: DatabaseValueConvertible?]]) throws -> Entity
    
    
    /// Returns a array of the database entities for the given field values.
    ///
    ///     let objects = try? repository.findAll(filterKeys: [["text": "Test"]])
    ///
    /// - parameter filterKeys: A dictionary of keys and values used to search for entities in the database.
    /// - throws: Exception handler.
    func findAll(filterKeys: [[String: DatabaseValueConvertible?]]?) throws -> [Entity]
    
    
    /// Saves the entity to the database and returns the saved entity.
    ///
    ///     let savedObject = try? repository.save(object: newObject)
    ///
    /// - parameter object: Entity to be saved to the database.
    /// - throws: Exception handler.
    func save(object: Entity) throws -> Entity
    
    
    /// Saves an array of entities to the database and returns the stored entities.
    ///
    ///     let savedObjects = try? repository.saveAll(objects: newObjects)
    ///
    /// - parameter objects: An array of entities to be saved to the database.
    /// - throws: Exception handler.
    func saveAll(objects: [Entity]) throws -> [Entity]
    
    
    /// Updates the entity to the database and returns the updated entity.
    ///
    ///     let updateObject = try? repository.update(object: updateObject)
    ///
    /// - parameter object: The entity to be updated in the database.
    /// - throws: Exception handler.
    func update(object: Entity) throws -> Entity
    
    
    /// Updates an array of entities to the database and returns the updated entities.
    ///
    ///     let updatedObjects = try? repository.updateAll(objects: updatedObjects)
    ///
    /// - parameter objects: An array of entities to be update to the database.
    /// - throws: Exception handler.
    func updateAll(objects: [Entity]) throws -> [Entity]
    
    
    /// Removes the specified entity from the database.
    ///
    ///     try? repository.delete(object: deletedObject)
    ///
    /// - parameter object: The entity to be deleted from the database.
    /// - throws: Exception handler.
    func delete(object: Entity) throws
    
    
    /// Removes the entity with the specified id from the database.
    ///
    ///     try? repository.delete(byId: 1)
    ///
    /// - parameter byId: Id of the object to be removed from the database
    /// - throws: Exception handler.
    func delete(byId id: Int64) throws
    
    
    /// Removes an array of specified entities from the database.
    ///
    ///     try? repository.deleteAll(objects: deletedObjects)
    ///
    /// - parameter objects: An array of entities to be deleted from the database.
    /// - throws: Exception handler.
    func deleteAll(objects: [Entity]) throws
    
    
    /// Returns the state of existence of the entity with the specified id in the database.
    ///
    ///     let isExist = try? repository.exist(byId: 1)
    ///
    /// - parameter byId: Id of the entity, the presence of which is checked in the database.
    /// - throws: Exception handler.
    func exist(byId id: Int64) throws -> Bool
    
    
    /// Returns the state of existence of the specified entity in the database.
    ///
    ///     let isExist = try? repository.exist(object: existObject)
    ///
    /// - parameter object: An entity that is checked for existence in the database.
    /// - throws: Exception handler.
    func exist(object: Entity) throws -> Bool
    
    
    /// Returns the number of entities in the database.
    ///
    ///     let count = try? repository.count()
    ///
    /// - throws: Exception handler.
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
