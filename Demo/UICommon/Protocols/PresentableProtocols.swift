//
//  PresentableProtocols.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

public protocol LoadingPresentable {
    var showLoading: BehaviorSubject<Bool> { get }
}

public protocol ErrorPresentable {
    var error: BehaviorSubject<Error?> { get }
}

public protocol TableViewPresentable {
    var configurations: BehaviorSubject<[SectionConfiguration]> { get }
}
