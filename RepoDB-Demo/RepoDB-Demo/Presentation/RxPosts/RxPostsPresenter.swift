//
//  RxPostsPresenter.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import RxSwift
import RepoDB

class RxPostsPresenter {
    
    // MARK: - Private Properties
    
    private var view: RxPostsView
    private let interactor = RxPostsInteractor()
    private let disposeBag = DisposeBag()
    
    // MARK: - Lifecycle
    
    init(view: RxPostsView) {
        self.view = view
    }
    
    // MARK: - Public Methods
    
    func fetchPosts() {
        interactor.fetchPosts()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] posts in
                self?.view.updateTableView(withPosts: posts)
                }, onError: { error in
                    print((error as! RepoDatabaseError).message)
            }).disposed(by: disposeBag)
    }
    
    func createPost() {
        view.showNewPostAlert()
    }
    
    func savePost(post: Post) {
        interactor.savePost(post: post)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] posts in
                self?.view.updateTableView(withPosts: posts)
            }).disposed(by: disposeBag)
    }
    
    func deletePost(post: Post) {
        interactor.deletePost(post: post)
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] posts in
                self?.view.updateTableView(withPosts: posts)
            }).disposed(by: disposeBag)
    }
}
