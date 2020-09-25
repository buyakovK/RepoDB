//
//  RxPostsViewController.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import UIKit
import RxSwift

class RxPostsViewController: UIViewController {
    
    // MARK: - Private Outlets
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var tableViewAdapter: TableViewAdapter?
    private let postsRepository: some RxPostRepository = Repositories.rxPostRepository
    private let postsConvertor = PostConvertor()
    private let disposeBag = DisposeBag()
    
    // MARK: - Constants
    
    private struct Constants {
        static let newPost = "New Post"
        static let placeholder = "Text"
        static let save = "Save"
        static let cancel = "Cancel"
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initAdapter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchPosts()
    }
    
    // MARK: - Private Methods
    
    private func initAdapter() {
        tableViewAdapter = TableViewAdapter(tableView: tableView)
        tableViewAdapter?.removeItem = { [weak self] post in
            self?.deletePost(post: post)
        }
    }
    
    private func fetchPosts() {
        postsRepository.findAll()
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dbPosts in
                self?.tableViewAdapter?.items = self?.postsConvertor.convertToPosts(dbPosts) ??  []
            }).disposed(by: disposeBag)
    }
    
    private func savePost(post: Post) {
        postsRepository.save(object: postsConvertor.convertToDatabasePost(post))
            .flatMap { _ in self.postsRepository.findAll() }
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dbPosts in
                self?.tableViewAdapter?.items = self?.postsConvertor.convertToPosts(dbPosts) ??  []
            }).disposed(by: disposeBag)
    }
    
    private func deletePost(post: Post) {
        postsRepository.delete(object: postsConvertor.convertToDatabasePost(post))
            .andThen(self.postsRepository.findAll())
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .background))
            .observeOn(MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] dbPosts in
                self?.tableViewAdapter?.items = self?.postsConvertor.convertToPosts(dbPosts) ??  []
            }).disposed(by: disposeBag)
    }
    
    private func createPost() {
        let alertController = UIAlertController(title: Constants.newPost, message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = Constants.placeholder
        }
        let saveAction = UIAlertAction(title: Constants.save, style: .default) { [weak self] _ in
            let text = alertController.textFields![0].text ?? ""
            let post = Post(text: text)
            self?.savePost(post: post)
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
    
    // MARK: - IBAcion
    
    @IBAction func addBarButtonTouchUpInside(_ sender: UIBarButtonItem) {
        createPost()
    }
}
