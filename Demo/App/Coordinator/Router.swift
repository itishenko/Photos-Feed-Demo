//
//  Router.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

public class Router {
    
    private weak var controller: UIViewController?
    
    public init(with controller: UIViewController? = nil){
        self.controller = controller
    }
    
    public var visibleViewController: UIViewController? {
        return topMostViewController
    }
    
    public var topMostViewController: UIViewController? {
        if let controller = controller {
            return topViewController(controller)
        } else {
            return topViewController()
        }
    }
    
    public func push(_ viewController: UIViewController, animated: Bool = true) {
        topMostViewController?.navigationController?.pushViewController(viewController, animated: animated)
    }
    
    public func topViewController(_ controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let navigationController = controller as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let presented = controller?.presentedViewController {
            return topViewController(presented)
        }
        return controller
    }
}
