//
//  BaseStarter.swift
//  Moviper
//
//  Created by marek on 29/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

open class BaseStarter<View> {
    open func startOn(viperView: ViperNavigator,
                 animated: Bool,
                 configurationBlock: ((View) -> ())?) {
        preconditionFailure("This method must be overridden")
    }
    
    open func startOn(viperView: ViperContainer,
                 inContainerView: ContainerView,
                 animated: Bool,
                 configurationBlock: ((View) -> ())?) {
        preconditionFailure("This method must be overridden")
    }
}
