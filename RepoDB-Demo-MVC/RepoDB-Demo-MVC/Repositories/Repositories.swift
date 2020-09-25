//
//  Repositories.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

class Repositories {
    
    static let postRepository: some PostRepository = PostDataRepository()
    static let rxPostRepository: some RxPostRepository = RxPostDataRepository()
}
