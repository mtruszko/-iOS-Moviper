//
//  BaseRxRouting.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

open class BaseRxRouting: ViperRxRouting {
    public init() { }
    public weak var viewController: UIViewController?
    
    open func attach(viewController: UIViewController?) {
        self.viewController = viewController
    }
    
    open func detach() {
        self.viewController = nil
    }
}
