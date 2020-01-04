//
//  Reactive+Compose.swift
//
//  Created by Ivan Tishchenko on 10.01.2020.
//  Copyright © 2020 itishenko. All rights reserved.
//

import Foundation
import RxSwift

public extension PrimitiveSequence where Trait == SingleTrait {
    
    func composeLoader(to holder: LoadingPresentable) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            holder.showLoading.onNext(false)
        }, onError: { _ in
            holder.showLoading.onNext(false)
        }, onSubscribed: {
            holder.showLoading.onNext(true)
        })
    }
    
    func composeLoadingAndError(to holder: LoadingPresentable & ErrorPresentable) -> PrimitiveSequence<SingleTrait, Element> {
        return self.do(onSuccess: { _ in
            holder.showLoading.onNext(false)
        }, onError: { error in
            holder.showLoading.onNext(false)
            holder.error.onNext(error)
        }, onSubscribed: {
            holder.showLoading.onNext(true)
        })
    }
    
    func subscribeOnMain(onSuccess: ((Element) -> Void)? = nil, onError: ((Error) -> Void)? = nil) -> Disposable {
        return observeOn(Schedulers.main).subscribe(onSuccess: onSuccess, onError: onError)
    }
}

public extension ObservableType {
    
    func subscribeOnMain(onNext: ((Self.E) -> Void)? = nil, onError: ((Error) -> Void)? = nil, onCompleted: (() -> Void)? = nil, onDisposed: (() -> Void)? = nil) -> Disposable {
        return observeOn(Schedulers.main).subscribe(onNext: onNext, onError: onError, onCompleted: onCompleted, onDisposed: onDisposed)
    }
}

