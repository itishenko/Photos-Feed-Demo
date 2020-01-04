//
//  PhotosListModuleOutputStub.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo

final class PhotosListModuleOutputStub: PhotosListModuleOutput {
    
    private(set) var openDetailsCount = 0

    var onPhotoDetails: ((_ photo: Photo) -> Void)?
    
    func openDetails(for photo: Photo) {
        openDetailsCount += 1
        onPhotoDetails?(photo)
    }
}
