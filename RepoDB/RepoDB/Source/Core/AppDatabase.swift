//
//  AppDatabase.swift
//  RepoDB
//
//  Created by Groot on 11.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import GRDB

var dbQueue: DatabaseQueue!

public final class AppDatabase {
    
    // MARK: - Private Properties
    
    private static let instance = AppDatabase()
    private var mirgationTypes: [DatabaseEntity.Type] = []
    private var migrator: DatabaseMigrator!
    
    // MARK: - Lifecycle
    
    private init() { }
    
    // MARK: - Public Methods
    
    public static func shared(mirgrationEntitiesTypes types: [DatabaseEntity.Type], migrationsName: String) -> AppDatabase {
        instance.mirgationTypes = types
        var migrator = DatabaseMigrator()
        migrator.registerMigration(migrationsName) { instance.createDatabase(db: $0) }
        instance.migrator = migrator
        return instance
    }
    
    public func setupDatabase(for application: UIApplication, withDataBaseName dbName: String = "db") {
        do {
            let databaseURL = try FileManager.default
                .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent("\(dbName).sqlite")
            dbQueue = try openDatabase(atPath: databaseURL.path)
        } catch {
            fatalError("Migration error")
        }
    }
    
    // MARK: - Private Methods
    
    private func openDatabase(atPath path: String) throws -> DatabaseQueue {
        print("DataBase path: \(path)")
        let dbQueue = try DatabaseQueue(path: path)
        try migrator.migrate(dbQueue)
        return dbQueue
    }
    
    private func createDatabase(db: Database) {
        self.mirgationTypes.forEach { createDatabaseTable(db: db, entity: $0) }
    }
    
    private func createDatabaseTable(db: Database, entity: DatabaseEntity.Type) {
        try? db.create(table: entity.databaseTableName, temporary: false, ifNotExists: true) { createDatabaseTableColumns(tableDefinition: $0, entity: entity) }
    }
    
    private func createDatabaseTableColumns(tableDefinition: TableDefinition, entity: DatabaseEntity.Type) {
        let columnEntity = entity.init()
        Mirror(reflecting: columnEntity).children.forEach { child in
            if let column = child.value as? PrimaryKeyColumnProtocol {
                configurePrimaryKeyColumn(tableDefinition: tableDefinition, column: column)
            } else if let column = child.value as? TableColumnProtocol {
                configureTableColumn(tableDefinition: tableDefinition, column: column)
            }
        }
    }
    
    private func configurePrimaryKeyColumn(tableDefinition: TableDefinition, column: PrimaryKeyColumnProtocol) {
        _ = column.autoincremented ? tableDefinition.autoIncrementedPrimaryKey(column.columnName) : tableDefinition.column(column.columnName, column.getType()).notNull()
    }
    
    private func configureTableColumn(tableDefinition: TableDefinition, column: TableColumnProtocol) {
        _ = column.nullable ? tableDefinition.column(column.columnName, column.getType()) : tableDefinition.column(column.columnName, column.getType()).notNull()
    }
}

