//
//  ViperRxPresenter.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

public protocol ViperRxPresenter {
    var name: String { get }
    var identifier: String { get }
    func attach(viperView: ViperRxView)
    func detach()
}
