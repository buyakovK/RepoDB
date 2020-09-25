//
//  PostConvertor.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

import Foundation

final class PostConvertor {
    
    func convertToPosts(_ dbPosts: [DatabasePost]) -> [Post] {
        return dbPosts.map { Post(id: $0.id ?? 0, text: $0.text ?? "") }
    }
    
    func convertToDatabasePost(_ post: Post) -> DatabasePost {
        let dbPost = DatabasePost()
        dbPost.id = post.id
        dbPost.text = post.text
        return dbPost
    }
}
