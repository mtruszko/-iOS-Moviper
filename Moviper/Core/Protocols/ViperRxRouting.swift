//
//  ViperRxRouting.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

public protocol ViperRxRouting {
    func attach(viewController: UIViewController?)
    func detach()
}
