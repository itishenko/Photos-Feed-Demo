//
//  PhotosListViewModel.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

class PhotosListViewModel: PhotosListModuleInput {
    
    // MARK: - Public properies
    
    var showPlaceholder = BehaviorSubject<Bool>(value: false)
    var configurations = BehaviorSubject<[SectionConfiguration]>(value: [])
    var showLoading = BehaviorSubject(value: false)
    var error: BehaviorSubject<Error?> = BehaviorSubject(value: nil)
    
    // MARK: - Private properies
    
    private let moduleOutput: PhotosListModuleOutput
    private let interactor: PhotosListInteractorProtocol
    private let bag = DisposeBag()
    
    private lazy var pagination = BasePaginationController<Photo>()
    
    // MARK: - Initialization
    
    init(output: PhotosListModuleOutput, interactor: PhotosListInteractorProtocol) {
        self.moduleOutput = output
        self.interactor = interactor
    }
}

// MARK: - PhotosListViewModelProtocol

extension PhotosListViewModel: PhotosListViewOutput {
    
    var emptyListText: String {
        return R.string.localizable.photosListEmpty()
    }
    
    func refresh() {
        pagination.reset()
        fetchPhotos()
    }
    
    func reachEnd() {
        fetchPhotos()
    }
    
    func viewDidLoad() {
        fetchPhotos()
    }
}

// MARK: - Private Methods

private extension PhotosListViewModel {
    
    func fetchPhotos() {
        guard pagination.checkAndLockLoading() else { return }
        
        interactor.getPhotos(page: pagination.page, limit: pagination.size)
            .composeLoadingAndError(to: self)
            .subscribe(onSuccess: { [weak self] photos in
                self?.pagination.receiveElements(photos)
                self?.showPlaceholder.onNext(photos.isEmpty)
                self?.reloadSections()
            }).disposed(by: bag)
    }
    
    func reloadSections() {
        configurations.onNext([
            BaseSectionConfiguration(
                rows: pagination.elements.map { photo in
                    return PhotoCellConfiguration(
                        title: photo.title,
                        imageResource: photo.thumbnailUrl.imageResource,
                        onClicked: { [weak self] _ in
                            self?.moduleOutput.openDetails(for: photo)
                        }
                    )
                }
            )
        ])
    }
}
