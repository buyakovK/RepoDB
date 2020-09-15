//
//  PostsTableViewAdapter.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import UIKit

class PostsTableViewAdapter: NSObject {
    
    // MARK: - Private Properties
    
    private var tableView: UITableView
    
    // MARK: - Lifecycle
    
    init(tableView: UITableView) {
        tableView.tableFooterView = UIView()
        self.tableView = tableView
        super.init()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    // MARK: - Public Properties
    
    var items: [Post] = [] {
        didSet {
            tableView.reloadSections(IndexSet(arrayLiteral: 0), with: .automatic)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension PostsTableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
}
