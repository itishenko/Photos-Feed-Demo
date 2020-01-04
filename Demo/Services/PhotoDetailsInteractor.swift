//
//  PhotoDetailsInteractor.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoDetailsInteractorProtocol {
    func getAlbum(albumId: Int) -> Single<Album>
    func getUser(userId: Int) -> Single<User>
    func getComments(photoId: Int) -> Single<[Comment]>
}

class PhotoDetailsInteractor: PhotoDetailsInteractorProtocol {

    private let apiClient: PhotosAPIClient
    
    init(apiClient: PhotosAPIClient) {
        self.apiClient = apiClient
    }
    
    func getAlbum(albumId: Int) -> Single<Album> {
        return Single<Album>.create { [weak self] observer in
            self?.apiClient.album(albumId: albumId) { result in
                observer(result.singleEvent)
            }
            return Disposables.create()
        }
    }
    
    func getUser(userId: Int) -> Single<User> {
        return Single<User>.create { [weak self] observer in
            self?.apiClient.user(userId: userId) { result in
                observer(result.singleEvent)
            }
            return Disposables.create()
        }
    }
    
    func getComments(photoId: Int) -> Single<[Comment]> {
        return Single<[Comment]>.create { [weak self] observer in
            self?.apiClient.comments(photoId: photoId) { result in
                observer(result.singleEvent)
            }
            return Disposables.create()
        }
    }
}
