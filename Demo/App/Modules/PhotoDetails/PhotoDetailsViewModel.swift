//
//  PhotoDetailsViewModel.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

class PhotoDetailsViewModel: PhotoDetailsModuleInput {
    
    // MARK: - Public properies
    
    var configuration = BehaviorSubject<PhotoDetailsViewConfiguration?>(value: nil)
    var showLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    var error: BehaviorSubject<Error?> = BehaviorSubject(value: nil)
    
    // MARK: - Private properies
    
    private let photo: Photo
    private let interactor: PhotoDetailsInteractorProtocol
    private let bag = DisposeBag()
    
    // MARK: - Initialization
    
    init(photo: Photo, interactor: PhotoDetailsInteractorProtocol) {
        self.photo = photo
        self.interactor = interactor
    }
}

// MARK: - PhotoDetailsViewModelProtocol

extension PhotoDetailsViewModel: PhotoDetailsViewOutput {
    
    func viewDidLoad() {
        fetchDetails()
    }
}

// MARK: - Private Methods

private extension PhotoDetailsViewModel {
    
    func fetchDetails() {
        Single.zip(
            interactor.getComments(photoId: photo.id),
            interactor.getAlbum(albumId: photo.albumId)
        )
        .composeLoadingAndError(to: self)
        .subscribe(onSuccess: { [weak self] comments, album in
            guard let self = self else { return }
            self.configuration.onNext(
                PhotoDetailsViewConfiguration(
                    imageResource: self.photo.url.imageResource,
                    title: self.photo.title,
                    userName: album.title,
                    commentsCount: String(comments.count)
                )
            )
        }).disposed(by: bag)
    }
}
