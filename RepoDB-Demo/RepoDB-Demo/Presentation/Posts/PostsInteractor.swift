//
//  PostsInteractor.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

class PostsInteractor {
    
    // MARK: - Private Properties
    
    private let postRepository: some PostsRepository = Repositories.postRepository
    private let postConvertor = PostConvertor()
    
    // MARK: - Public Methods
    
    func fetchPosts() -> [Post] {
        guard let posts = try? postRepository.findAll() else { return [] }
        return postConvertor.convertToPosts(posts)
    }
    
    func savePost(post: Post) -> [Post] {
        let dbPost = postConvertor.convertToDatabasePost(post)
        _ = try? postRepository.save(object: dbPost)
        return fetchPosts()
    }
    
    func deletePost(post: Post) -> [Post] {
        try? postRepository.delete(object: postConvertor.convertToDatabasePost(post))
        return fetchPosts()
    }
    
}
