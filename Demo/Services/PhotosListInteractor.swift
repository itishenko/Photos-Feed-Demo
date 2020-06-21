//
//  DemoInteractor.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

protocol PhotosListInteractorProtocol: AutoMockable {
    func getPhotos(page: Int, limit: Int) -> Single<[Photo]>
}

class PhotosListInteractor: PhotosListInteractorProtocol {

    private let apiClient: PhotosAPIClient
    
    init(apiClient: PhotosAPIClient) {
        self.apiClient = apiClient
    }
    
    func getPhotos(page: Int, limit: Int) -> Single<[Photo]> {
        return Single<[Photo]>.create { [weak self] observer in
            self?.apiClient.photos(page: page, limit: limit) { result in
                observer(result.singleEvent)
            }
            return Disposables.create()
        }
    }
}
