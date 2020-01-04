//
//  PhotosListInteractorStub.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import RxSwift
import RxTest

final class PhotosListInteractorStub: PhotosListInteractorProtocol {
    
    private let scheduler: TestScheduler
    private let photos: [Photo]
    
    private(set) var currentPage: Int
    
    init(scheduler: TestScheduler, photos: [Photo] = [], currentPage: Int = 0) {
        self.scheduler = scheduler
        self.photos = photos
        self.currentPage = currentPage
    }
    
    func getPhotos(page: Int, limit: Int) -> Single<[Photo]> {
        currentPage = page
        return scheduler.createColdSingle(photos)
    }
}

