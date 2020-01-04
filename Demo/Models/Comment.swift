//
//  Comment.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

struct Comment: Decodable {
    let id: Int
    let postId: Int
    let body: String
    let name: String
    let email: String
}
