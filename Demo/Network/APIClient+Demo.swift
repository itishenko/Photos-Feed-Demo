//
//  APIClient+Demo.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import Alamofire

protocol PhotosAPIClient {
    func photos(page: Int, limit: Int, completion: @escaping (Result<[Photo]>) -> Void)
    func user(userId: Int, completion: @escaping (Result<User>) -> Void)
    func album(albumId: Int, completion: @escaping (Result<Album>) -> Void)
    func comments(photoId: Int, completion: @escaping (Result<[Comment]>) -> Void)
}

extension APIClient: PhotosAPIClient {
    func photos(page: Int, limit: Int, completion: @escaping (Result<[Photo]>) -> Void) {
        let parameters = [
            "_page": page,
            "_limit": limit
        ]
        requestItem(request: DemoAPI.photos(parameters: parameters), onCompletion: completion)
    }
    
    func user(userId: Int, completion: @escaping (Result<User>) -> Void) {
        requestItem(request: DemoAPI.user(userId: String(userId)), onCompletion: completion)
    }
    
    func album(albumId: Int, completion: @escaping (Result<Album>) -> Void) {
        requestItem(request: DemoAPI.albums(albumId: String(albumId)), onCompletion: completion)
    }
    
    func comments(photoId: Int, completion: @escaping (Result<[Comment]>) -> Void) {
        requestItem(request: DemoAPI.comments(photoId: String(photoId)), onCompletion: completion)
    }
}
