//
//  PaginationController.swift
//  Demo
//
//  Created by Ivan Tishchenko on 11.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation

public enum PaginationState {
    case ready
    case loading
    case all
    
    public enum Constants {
        public static let pageSize: Int = 16
    }
}

public protocol PaginationController {
    associatedtype Element

    var size: Int { get }
    var page: Int { get }
    var elements: [Element] { get }

    func reset()
    func checkAndLockLoading() -> Bool

    func receiveElements(_ elements: [Element])
}

public class BasePaginationController<T>: PaginationController {

    public var size: Int
    public var page: Int {
        return elements.count / size
    }

    fileprivate(set) public var state: PaginationState = .ready
    fileprivate(set) public var elements: [T] = [T]()
    
    public init(_ size: Int = PaginationState.Constants.pageSize) {
        self.size = size
    }

    public func reset() {
        elements.removeAll()
        state = .ready
    }

    public func checkAndLockLoading() -> Bool {
        guard case .ready = state else { return false }
        state = .loading
        return true
    }

    public func receiveElements(_ elements: [T]) {
        self.elements.append(contentsOf: elements)

        if elements.count < size {
            state = .all
        } else {
            state = .ready
        }
    }

    func unlockLoading() {
        if case .loading = state {
            state = .ready
        }
    }
}
