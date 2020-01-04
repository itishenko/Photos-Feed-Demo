//
//  TestScheduler+Extension.swift
//  DemoTests
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import RxSwift
import RxTest

extension TestScheduler {
    
    func createColdSingle<T>(_ result: T) -> Single<T> {
        createColdObservable([.next(0, result), .completed(1)]).asSingle()
    }
    
    func restart() {
        stop()
        start()
    }
    
}
