//
//  DependencyProvider.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import Swinject

class DependencyProvider {

    let container = Container()
    let assembler: Assembler

    init() {
        assembler = Assembler(
            [
                DemoAssembly()
            ],
            container: container
        )
    }
}
