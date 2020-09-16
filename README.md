# RepoDB

RepoDB is a framework for working with the SQLite database based on GRDB and RxSwift

- [Features](#Features)
- [Versions](#Versions)
- [Requirements](#Requirements)
- [Communication](#Communication)
- [Installation](#Installation)
- [Usage](#Usage)
- [License](#License)

## Features

- Automatic migrations
- Get/Save/Update/Delete/Exist/Count methods
- Working with the database is based on the repository pattern
- RxSwift support

## Versions

 |  Swift version  |  RepoDB version  |
 |-----------------|------------------|
 |       5.1       |       0.0        |
 |       5.0       |       0.0        |

## Requirements

iOS 10.0+ / macOS 10.10+ / tvOS 9.0+ / watchOS 2.0+ • Swift 5+ / Xcode 11.4+

## Installation


To integrate RepoDB into your Xcode project using [CocoaPods](https://cocoapods.org), specify it in your `Podfile`:

```bash
pod 'RepoDB', '~> 0.0'
```

## Usage


An example code sample is provided in this repository in the RepoDB-Demo package.

### Initializing database entities (tables)

To create a database table, use structures confirm to `DatabaseEntity` protocol. 
All fields of this structure must be optional. 
You can set the table name by defining the static property `databaseTableName`. 
Property Wrappers (annotations/attributes) `@PrimaryKeyColumn` and `@TableColumn` are used to set table columns.
`@PrimaryKeyColumn` contains parameters such as `name` and `autoincremented`: `name` is the name of the column in the table, `autoincremented` is the automatic addition of the next value. Using `@PrimaryKeyColumn` makes this field the primary key for this table.
`@TableColumn` contains parameters such as `name` and `nullable`: `name` is the name of the column in the table, `nullable` is whether this field can be null. Using `@TableColumn` makes this field a regular table column.

```swift
struct DatabasePost: DatabaseEntity {
    
    static var databaseTableName: String = "Posts"
    
    @PrimaryKeyColumn(name: "id", autoincremented: true)
    var id: Int64?
    
    @TableColumn(name: "text", nullable: false)
    var text: String?
    
    init() { }
}
```


### Initializing database and migrations

When starting the application to perform the migration, call the method passing the parameters to it: `mirgrationEntitiesTypes` - фт array of database entity types, `migrationsName` - the name of the migration

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    AppDatabase.shared(mirgrationEntitiesTypes: [DatabasePost.self], migrationsName: "v1").setupDatabase(for: application)
    return true
}
```


### Work with database

To execute queries to the database, you need to create a empty protocol confirm to DatabaseRepository, in the associatedtype of which the database entity is transferred, with which work will be carried out using this repository.

```swift
protocol PostsRepository: DatabaseRepository where Entity == DatabasePost { }
```


In order to use the methods for working with the entity, a empty class is created confirm to created protocol.

```swift
class PostsDataRepository: PostsRepository { }
```


In the class where the methods for accessing the database are called, an instance of the repository is created:

```swift
private let postRepository: some PostsRepository = PostsDataRepository()
```

You now have access to database query methods such as `findAll()`, `save(object:)` and so on:

```swift
func fetchPosts() -> [DatabasePost] {
    guard let posts = try? postRepository.findAll() else { return [] }
    return posts
}

func savePost(post: DatabasePost) -> [DatabasePost] {
    _ = try? postRepository.save(object: post)
    return fetchPosts()
}
```


### Description of all database queries

`func find(byId id: Int64) throws -> Entity` - returns the entity of the database by id.
    
Example: 

```swift
var object = try? repository.find(byId: 1)
```


`func find(filterKeys: [[String: DatabaseValueConvertible?]]) throws -> Entity` - returns the database entity for the given field values.
    
Example: 

```swift
var object = try? repository.find(filterKeys: [["id": "1"], ["text": "Test"]])
```


`func findAll(filterKeys: [[String: DatabaseValueConvertible?]]?) throws -> [Entity]` - returns a array of the database entities for the given field values.
    
Example: 

```swift
var objects = try? repository.findAll(filterKeys: [["text": "Test"]])
```


`func findAll(page: Int, count: Int) throws -> DatabasePaginationEntity<Entity>` - returns a pagination model that contains metadata and an array of entities of the specified length on the specified page.
    
Example: 

```swift
var paginationObject = try? repository.findAll(page: 2, count: 10)
```


`func save(object: Entity) throws -> Entity` - saves the entity to the database and returns the saved entity.

Example:

```swift
var savedObject = try? repository.save(object: newObject)
```


`func saveAll(objects: [Entity]) throws -> Entity` - saves an array of entities to the database and returns the stored entities.

Example:

```swift
var savedObjects = try? repository.saveAll(objects: newObjects)
```


`func update(object: Entity) throws -> Entity` - updates the entity to the database and returns the updated entity.

Example:

```swift
var updateObject = try? repository.update(object: updateObject)
```


`func updateAll(objects: [Entity]) throws -> [Entity]` - updates an array of entities to the database and returns the updated entities.

Example:

```swift
var updatedObjects = try? repository.updateAll(objects: updatedObjects)
```


`func delete(byId id: Int64) throws` - removes the entity with the specified id from the database.
    
Example: 

```swift
try? repository.delete(byId: 1)
```


`func delete(object: Entity) throws` - removes the specified entity from the database.
    
Example: 

```swift
try? repository.delete(object: deletedObject)
```


`func deleteAll(objects: [Entity]) throws` - removes an array of specified entities from the database.
    
Example: 

```swift
try? repository.deleteAll(objects: deletedObjects)
```


`func exist(byId id: Int64) throws -> Bool` - returns the state of existence of the entity with the specified id in the database.
    
Example: 

```swift
var isExist = try? repository.exist(byId: 1)
```


`func exist(object: Entity) throws -> Bool` - returns the state of existence of the specified entity in the database.
    
Example: 

```swift
var isExist = try? repository.exist(object: existObject)
```


`func count() throws -> Int` - returns the number of entities in the database.
    
Example: 

```swift
var count = try? repository.count()
```

## Contributing

- Pull requests are welcome. 
- For major changes, please open an issue first to discuss what you would like to change.

## License
RepoDB is released under the MIT license. See [LICENSE](https://github.com/buyakovK/RepoDB/blob/master/LICENSE) for details.
