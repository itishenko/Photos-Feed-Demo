//
//  BaseTestCase.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

@testable import Demo
import XCTest
import RxSwift
import RxTest

class BaseTestCase: XCTestCase {
    
    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!
    
    override func setUp() {
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        Schedulers.setProvider(TestSchedulersProvider(testScheduler: scheduler))
    }
    
    override func tearDown() {
        disposeBag = nil
        scheduler = nil
    }
}
