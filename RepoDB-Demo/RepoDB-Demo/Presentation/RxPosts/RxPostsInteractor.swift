//
//  RxPostsInteractor.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import RxSwift

class RxPostsInteractor {
    
    // MARK: - Private Properties
    
    private let postRepository: some RxPostsRepository = Repositories.rxPostRepository
    private let postConvertor = PostConvertor()
    
    // MARK: - Public Methods
    
    func fetchPosts() -> Single<[Post]> {
        return postRepository.findAll()
            .map { self.postConvertor.convertToPosts($0) }
    }
    
    func savePost(post: Post) -> Single<[Post]> {
        let dbPost = postConvertor.convertToDatabasePost(post)
        return postRepository.save(object: dbPost)
            .flatMap { _ in self.fetchPosts() }
    }
    
}
