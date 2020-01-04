//
//  Result+SingleEvent.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Alamofire
import RxSwift

extension Result {
    
    var singleEvent: SingleEvent<Value> {
        switch self {
        case .success(let value):
            return .success(value)
        case .failure(let error):
            return .error(error)
        }
    }
}
