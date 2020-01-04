//
//  CustomError.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public final class CustomError: LocalizedError, Decodable {
    
    private let description: String
    
    // MARK: - LocalizedError
    
    public var errorDescription: String? { return description }
    public var failureReason: String? { return description }
    
    // MARK: - Decodable
    
    enum CodingKeys: String, CodingKey {
        case description = "error"
    }
    
    // MARK: - Initialization
    
    public init(description: String) {
        self.description = description
    }
}

public extension CustomError {
    
    static var parsingError: Error {
        return CustomError(description: R.string.localizable.errorGeneral())
    }
}

