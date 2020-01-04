//
//  PhotoDetailsInitializer.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

protocol PhotoDetailsModuleInput: AnyObject {}

protocol PhotoDetailsViewOutput: AnyObject, LoadingPresentable, ErrorPresentable {
    
    var configuration: BehaviorSubject<PhotoDetailsViewConfiguration?> { get }
    func viewDidLoad()
}

enum PhotoDetailsModuleInitializer {
    
    static func initialize(photo: Photo, interactor: PhotoDetailsInteractorProtocol) -> (view: PhotoDetailsViewController, input: PhotoDetailsModuleInput) {
        
        let viewModel = PhotoDetailsViewModel(
            photo: photo,
            interactor: interactor
        )
        let view = PhotoDetailsViewController(with: viewModel)
        return (view: view, input: viewModel)
    }
}
