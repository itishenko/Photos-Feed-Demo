//
//  Photo.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

struct Photo: Decodable {
    let id: Int

    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
