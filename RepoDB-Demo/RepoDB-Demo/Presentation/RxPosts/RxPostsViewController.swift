//
//  RxPostsViewController.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import UIKit

class RxPostsViewController: UIViewController {
    
    // MARK: - Private Outlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Constants
    
    private struct Constants {
        static let newPost = "New Post"
        static let placeholder = "Text"
        static let save = "Save"
        static let cancel = "Cancel"
    }
    
    // MARK: - Private Properties
    
    private var tableViewAdapter: PostsTableViewAdapter!
    private var presenter: RxPostsPresenter!
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initDependencies()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.fetchPosts()
    }
    
    // MARK: - Private Methods
    
    private func initDependencies() {
        presenter = RxPostsPresenter(view: self)
        tableViewAdapter = PostsTableViewAdapter(tableView: tableView)
        tableViewAdapter.removeItem = { [weak self] post in
            self?.presenter.deletePost(post: post)
        }
    }
    
    // MARK: - IBAction
    
    @IBAction func addPostBarButtonTouchUpInside(_ sender: UIBarButtonItem) {
        presenter.createPost()
    }
    
}

extension RxPostsViewController: RxPostsView {
    
    func updateTableView(withPosts posts: [Post]) {
        tableViewAdapter?.items = posts
    }
    
    func showNewPostAlert() {
        let alertController = UIAlertController(title: Constants.newPost, message: "", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = Constants.placeholder
        }
        let saveAction = UIAlertAction(title: Constants.save, style: .default) { [weak self] _ in
            let text = alertController.textFields![0].text ?? ""
            let post = Post(text: text)
            self?.presenter.savePost(post: post)
        }
        let cancelAction = UIAlertAction(title: Constants.cancel, style: .cancel, handler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
