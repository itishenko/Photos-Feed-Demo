//
//  Logger.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public let log: Logger = ConsoleLogger()

public protocol Logger {
    func debug(_ message: Any)
}

final class ConsoleLogger: Logger {
    
    func debug(_ message: Any) {
        print(message)
    }
}
