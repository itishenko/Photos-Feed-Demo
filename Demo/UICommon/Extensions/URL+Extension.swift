//
//  URL+Extension.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public extension URL {
    
    var imageResource: ImageResource? {
        guard !absoluteString.isEmpty else { return nil }
        return .url(self)
    }
}
