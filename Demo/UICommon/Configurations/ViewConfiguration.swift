//
//  ViewConfiguration.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import UIKit

public protocol ViewConfiguration {
    var viewType: ConfigurableView.Type { get }
    var height: CGFloat { get }
    var width: CGFloat? { get }
}

public extension ViewConfiguration {
    var width: CGFloat? { return nil }
}

public protocol ConfigurableView: UIView {
    init()
    func configure(_ configuration: ViewConfiguration)
}

