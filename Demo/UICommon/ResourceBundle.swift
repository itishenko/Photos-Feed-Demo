//
//  ResourceBundle.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

import Foundation

final class ResourceBundle: Bundle {

    static var shared: Bundle {
        let bundleURL = Bundle(for: ResourceBundle.self).bundleURL
        return ResourceBundle(url: bundleURL)!
    }
}
