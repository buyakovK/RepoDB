//
//  DatabasePost.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import RepoDB

struct DatabasePost: DatabaseEntity {
    
    static var databaseTableName: String = "Posts"
    
    @PrimaryKeyColumn(name: "id", autoincremented: true)
    var id: Int64?
    
    @TableColumn(name: "text", nullable: false)
    var text: String?
    
    init() { }
}
