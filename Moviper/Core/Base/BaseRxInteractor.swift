//
//  BaseRxInteractor.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import RxSwift

open class BaseRxInteractor: BaseRx, ViperRxInteractor {
    public override init () { }
    open func attach() { }
    open func detach() { }
}
