//
//  RxDatabasePaginationRepository.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import RxSwift

public protocol RxDatabasePaginationRepository: RxDatabaseRepository, DatabasePaginationRepository {
    
    func findAll(page: Int, count: Int) -> Single<DatabasePaginationEntity<Entity>>
}

public extension RxDatabasePaginationRepository {
    func findAll(page: Int, count: Int) -> Single<DatabasePaginationEntity<Entity>> {
        return Single.create { single -> Disposable in
            do {
                let result: DatabasePaginationEntity = try self.findAll(page: page, count: count)
                single(.success(result))
            } catch {
                single(.error(error))
            }
            return Disposables.create()
        }
    }
}
