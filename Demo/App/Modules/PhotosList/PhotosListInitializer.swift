//
//  PhotosListInitializer.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotosListModuleInput: AnyObject {
}

protocol PhotosListModuleOutput: AnyObject, AutoMockable {
    func openDetails(for photo: Photo)
}

protocol PhotosListViewOutput: AnyObject, LoadingPresentable, ErrorPresentable, TableViewPresentable {
    
    var emptyListText: String { get }
    var showPlaceholder: BehaviorSubject<Bool> { get }
    
    func viewDidLoad()
    func refresh()
    func reachEnd()
}

enum PhotosListModuleInitializer {
    
    static func initialize(interactor: PhotosListInteractorProtocol, output: PhotosListModuleOutput) -> (view: PhotosListViewController, input: PhotosListModuleInput) {
        
        let viewModel = PhotosListViewModel(
            output: output,
            interactor: interactor
        )
        let view = PhotosListViewController(with: viewModel)
        return (view: view, input: viewModel)
    }
}
