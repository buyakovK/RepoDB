//
//  PostRepository.swift
//  RepoDB-Demo-MVC
//
//  Created by Groot on 25.09.2020.
//  Copyright © 2020 K. All rights reserved.
//

import RepoDB

protocol PostRepository: DatabaseRepository where Entity == DatabasePost { }
