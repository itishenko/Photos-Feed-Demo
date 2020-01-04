//
//  Schedulers.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

public protocol SchedulersProvider {
    
    var io: SchedulerType { get }
    var calculation: SchedulerType { get }
    var main: SchedulerType { get }
    
}

public struct BaseSchedulers: SchedulersProvider {
    
    public let io: SchedulerType = SerialDispatchQueueScheduler(qos: .background)
    public let calculation: SchedulerType = SerialDispatchQueueScheduler(qos: .userInitiated)
    public let main: SchedulerType = MainScheduler.instance
    
}

public class Schedulers {
    
    private static var provider: SchedulersProvider = BaseSchedulers()
    
    public static var io: SchedulerType { provider.io }
    public static var calculation: SchedulerType { provider.calculation }
    public static var main: SchedulerType { provider.main }
    
    public static func setProvider(_ provider: SchedulersProvider) {
        self.provider = provider
    }
}
