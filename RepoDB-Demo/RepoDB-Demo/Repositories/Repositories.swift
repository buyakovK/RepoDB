//
//  Repositories.swift
//  RepoDB
//
//  Created by Groot on 14.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import Foundation

final class Repositories {
    static let rxPostRepository: some RxPostsRepository = RxPostsDataRepository()
    static let postRepository: some PostsRepository = PostsDataRepository()
}
