//
//  PostConvertor.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

final class PostConvertor {
    
    func convertToPosts(_ dbPosts: [DatabasePost]) -> [Post] {
        return dbPosts.map { Post(id: $0.id, text: $0.text ?? "") }
    }
    
    func convertToDatabasePost(_ post: Post) -> DatabasePost {
        let dbPost = DatabasePost()
        dbPost.text = post.text
        return dbPost
    }
}
