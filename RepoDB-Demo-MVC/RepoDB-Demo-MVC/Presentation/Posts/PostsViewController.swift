//
//  PostsViewController.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Private Properties
    
    private var tableViewAdapter: TableViewAdapter?
    private let postsRepository: some PostRepository = Repositories.postRepository
    private let postsConvertor = PostConvertor()
    
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
        let posts = try? postsRepository.findAll()
        tableViewAdapter?.items = postsConvertor.convertToPosts(posts ?? [])
    }
    
    private func savePost(post: Post) {
        let dbPost = postsConvertor.convertToDatabasePost(post)
        _ = try? postsRepository.save(object: dbPost)
        fetchPosts()
    }
    
    private func deletePost(post: Post) {
        let dbPost = postsConvertor.convertToDatabasePost(post)
        try? postsRepository.delete(object: dbPost)
        fetchPosts()
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
    
    // MARK: - IBActions
    
    @IBAction func addButtonTouchUpInside(_ sender: UIBarButtonItem) {
        createPost()
    }
}
