//
//  MocksBuilder.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import Foundation

enum FakeData {
    
    static var photo1: Photo {
        Photo(
            id: 1,
            albumId: 1,
            title: "est necessitatibus architecto ut laborum",
            url: URL(string: "https://via.placeholder.com/600/61a61")!,
            thumbnailUrl: URL(string: "https://via.placeholder.com/150/61a61")!
        )
    }
    
    static var photo2: Photo {
        Photo(
            id: 2,
            albumId: 1,
            title: "sdfdsjhf dsfoisdusdfiuds",
            url: URL(string: "https://via.placeholder.com/600/61a62")!,
            thumbnailUrl: URL(string: "https://via.placeholder.com/150/61a62")!
        )
    }
    
    static var photos: [Photo] {
        [
            photo1,
            photo2
        ]
    }
}
