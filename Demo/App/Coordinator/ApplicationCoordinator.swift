//
//  ApplicationCoordinator.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class ApplicationCoordinator: Coordinator {
    
    // MARK: - Private Properties
    
    private let window: UIWindow
    private let resolver: Resolver
    
    // MARK: - Initialization
    
    init(window: UIWindow, router: Router, resolver: Resolver) {
        self.window = window
        self.resolver = resolver
        super.init(with: router)
    }
    
    // MARK: - Public Methods
    
    func start() {
        let nc = UINavigationController()
        let (vc, _) = PhotosListModuleInitializer.initialize(
            interactor: resolver.resolve(PhotosListInteractorProtocol.self)!,
            output: self
        )
        nc.setViewControllers([vc], animated: false)
        window.rootViewController = nc
    }
}

extension ApplicationCoordinator: PhotosListModuleOutput {
    func openDetails(for photo: Photo) {
        let (vc, _) = PhotoDetailsModuleInitializer.initialize(
            photo: photo,
            interactor: resolver.resolve(PhotoDetailsInteractorProtocol.self)!
        )
        router.push(vc)
    }
}
