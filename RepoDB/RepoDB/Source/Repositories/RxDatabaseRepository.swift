//
//  RxDatabaseRepository.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB
import RxSwift

public protocol RxDatabaseRepository: DatabaseRepository {
    
    func find(byId id: Int64) -> Single<Entity>
    func find(filterKeys: [[String: DatabaseValueConvertible?]]) -> Single<Entity>
    func findAll(filterKeys: [[String: DatabaseValueConvertible?]]?) -> Single<[Entity]>
    func save(object: Entity) -> Single<Entity>
    func saveAll(object: [Entity]) -> Single<[Entity]>
    func update(object: Entity) -> Single<Entity>
    func updateAll(objects: [Entity]) -> Single<[Entity]>
    func delete(object: Entity) -> Completable
    func delete(byId: Int64) -> Completable
    func deleteAll(objects: [Entity]) -> Completable
    func exist(byId id: Int64) -> Single<Bool>
    func exist(object: Entity) -> Single<Bool>
    func count() -> Single<Int>
}

public extension RxDatabaseRepository {
    
    // MARK: - Find
    
    func find(byId id: Int64) -> Single<Entity> {
        return Single.create { single -> Disposable in
            do {
                let entity: Entity = try self.find(byId: id)
                single(.success(entity))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func find(filterKeys: [[String: DatabaseValueConvertible?]]) -> Single<Entity> {
        return Single.create { single -> Disposable in
            do {
                let entity: Entity = try self.find(filterKeys: filterKeys)
                single(.success(entity))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func findAll(filterKeys: [[String: DatabaseValueConvertible?]]? = nil) -> Single<[Entity]> {
        return Single.create { single -> Disposable in
            do {
                let entities: [Entity] = try self.findAll(filterKeys: filterKeys)
                single(.success(entities))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Save
    
    func save(object: Entity) -> Single<Entity> {
        return Single.create { single -> Disposable in
            do {
                let entity: Entity = try self.save(object: object)
                single(.success(entity))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func saveAll(object: [Entity]) -> Single<[Entity]> {
        return Single.create { single -> Disposable in
            do {
                let entities: [Entity] = try self.updateAll(objects: object)
                single(.success(entities))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Update
    
    func update(object: Entity) -> Single<Entity> {
        return Single.create { single -> Disposable in
            do {
                let entity: Entity = try self.update(object: object)
                single(.success(entity))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func updateAll(objects: [Entity]) -> Single<[Entity]> {
        return Single.create { single -> Disposable in
            do {
                let entities: [Entity] = try self.updateAll(objects: objects)
                single(.success(entities))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Delete
    
    func delete(object: Entity) -> Completable {
        return Completable.create { completableEvent -> Disposable in
            do {
                let _: Void = try self.delete(object: object)
                completableEvent(.completed)
            } catch {
                completableEvent(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func delete(byId id: Int64) -> Completable {
        return self.find(byId: id)
            .flatMapCompletable { self.delete(object: $0) }
    }
    
    func deleteAll(objects: [Entity]) -> Completable {
        return Completable.create { completableEvent -> Disposable in
            do {
                let _: Void = try self.deleteAll(objects: objects)
                completableEvent(.completed)
            } catch {
                completableEvent(.error(error))
            }
            return Disposables.create()
        }
    }
    
    // MARK: - Exist
    
    func exist(object: Entity) -> Single<Bool> {
        return Single.create { single -> Disposable in
            do {
                let isExist: Bool = try self.exist(object: object)
                single(.success(isExist))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
    
    func exist(byId id: Int64) -> Single<Bool> {
        return self.find(byId: id)
            .flatMap { self.exist(object: $0) }
    }
    
    
    // MARK: - Delete
    
    func count() -> Single<Int> {
        return Single.create { single -> Disposable in
            do {
                let count: Int = try self.count()
                single(.success(count))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
