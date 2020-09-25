//
//  TableViewAdapter.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import UIKit

class TableViewAdapter: NSObject {
    
    // MARK: - Private Properties
    
    private var tableView: UITableView
    
    // MARK: - CallBack
    
    var removeItem: ((Post) -> Void)?
    
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

extension TableViewAdapter: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.row].text
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            removeItem?(items[indexPath.row])
        }
    }
}
