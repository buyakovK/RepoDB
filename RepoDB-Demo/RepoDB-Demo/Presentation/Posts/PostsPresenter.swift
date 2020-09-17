//
//  PostsPresenter.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

class PostsPresenter {
    
    // MARK: - Private Properties
    
    private var view: PostsView
    private let interactor = PostsInteractor()
    
    // MARK: - Lifecycle
    
    init(view: PostsView) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func fetchPosts() {
        view.updateTableView(withPosts: interactor.fetchPosts())
    }
    
    func createPost() {
        view.showNewPostAlert()
    }
    
    func savePost(post: Post) {
        view.updateTableView(withPosts: interactor.savePost(post: post))
    }
    
    func deletePost(post: Post) {
        view.updateTableView(withPosts: interactor.deletePost(post: post))
    }
}
