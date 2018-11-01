//
//  BaseRx.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import RxSwift

open class BaseRx {
    var compositeDisposable = CompositeDisposable()
    
    public func addSubscription(subscription: Disposable?) {
        guard subscription != nil else {
            return
        }
        _ = compositeDisposable.insert(subscription!)
    }
}
