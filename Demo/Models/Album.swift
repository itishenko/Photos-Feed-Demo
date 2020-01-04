//
//  Album.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

struct Album: Decodable {
    let id: Int
    let userId: Int
    let title: String
}
