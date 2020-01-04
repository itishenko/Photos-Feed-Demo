//
//  ResourceRouter.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import UIKit

struct ResourceRouter {

    static func nib(forType anyClass: AnyClass, nibName: String? = nil) -> UINib {
        let nibName = nibName ?? String(describing: anyClass)
        let bundle = bundleForNibWithClass(anyClass)
        return UINib(nibName: nibName, bundle: bundle)
    }

    static func nib<T: AnyObject>(forObject anyObject: T, nibName: String? = nil) -> UINib {
        let anyClass = type(of: anyObject)
        let nibName = nibName ?? String(describing: anyClass)
        let bundle = bundleForNibWithClass(anyClass)
        return UINib(nibName: nibName, bundle: bundle)
    }

    private static func bundleForNibWithClass(_ anyClass: AnyClass) -> Bundle {
        let nibName = String(describing: anyClass)
        if ResourceBundle.shared.url(forResource: nibName, withExtension: "nib") != nil {
            return ResourceBundle.shared
        } else {
            return Bundle(for: anyClass)
        }
    }
}
