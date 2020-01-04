//
//  Coordinator.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

open class Coordinator: NSObject {
    
    public var childCoordinators: [Coordinator] = []
    
    public let router: Router
    
    public var onFinishFlow: (() -> Void)?
    
    public init(with router: Router) {
        self.router = router
    }

    public func addDependency(_ element: Coordinator) {
        guard childCoordinators.first(where: { $0 === element }) == nil else { return }
        childCoordinators.append(element)
    }
    
    public func removeDependency(_ element: Coordinator?) {
        guard !childCoordinators.isEmpty, let element = element else { return }
        if let index = childCoordinators.firstIndex(where: { $0 === element }) {
            childCoordinators.remove(at: index)
        }
    }
}
