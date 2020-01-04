//
//  TestSchedulerProvider.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import RxSwift
import RxTest

struct TestSchedulersProvider: SchedulersProvider {
    
    private let testScheduler: TestScheduler
    
    var io: SchedulerType { testScheduler }
    var calculation: SchedulerType { testScheduler }
    var main: SchedulerType { testScheduler }
    
    init(testScheduler: TestScheduler) {
        self.testScheduler = testScheduler
    }
    
}
