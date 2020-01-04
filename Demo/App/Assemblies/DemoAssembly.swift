//
//  DemoAssembly.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import Swinject

class DemoAssembly: Assembly {
        
    func assemble(container: Container) {
        container.register(PhotosAPIClient.self) { _ in APIClient() }
        container.register(PhotosListInteractorProtocol.self) { r in
            PhotosListInteractor(apiClient: r.resolve(PhotosAPIClient.self)!)
        }
        container.register(PhotoDetailsInteractorProtocol.self) { r in
            PhotoDetailsInteractor(apiClient: r.resolve(PhotosAPIClient.self)!)
        }
    }
}
