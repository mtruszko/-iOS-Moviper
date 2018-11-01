//
//  BaseRxPresenter.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit
import RxSwift

open class BaseRxPresenter
    <InteractorType: ViperRxInteractor, RoutingType: ViperRxRouting, ViewType: ViperRxView>
: BaseRx, ViperRxPresenter {
    
    public var interactor: InteractorType!
    public var routing: RoutingType!
    public weak var view: ViewType?
    
    public let name = Moviper.DEFAULT_NAME
    public let identifier: String = UUID().uuidString
    
    override public init() {
        super.init()
        self.routing = createRouting()
        self.interactor = createInteractor()
    }
    
    init(routing: RoutingType, interactor: InteractorType) {
        self.routing = routing
        self.interactor = interactor
    }
    
    open func attach(viperView: ViperRxView) {
        self.view = viperView as? ViewType
        routing.attach(viewController: view as? UIViewController)
        interactor.attach()
        Moviper.sharedInstance.register(presenter: self)
        if compositeDisposable.isDisposed {
            compositeDisposable = CompositeDisposable()
        }
    }
    
    open func detach() {
        compositeDisposable.dispose()
        Moviper.sharedInstance.unregister(presenter: self)
        interactor.detach()
        routing.detach()
    }
    
    open func createRouting() -> RoutingType {
        preconditionFailure("This method must be overridden")
    }
    
    open func createInteractor() -> InteractorType {
        preconditionFailure("This method must be overridden")
    }
}

extension Array where Element == ViperRxPresenter {
    mutating func appendPresenter(presenter: Element, view: ViperRxView) {
        guard !(contains { ($0 as AnyObject) === (presenter as AnyObject) }) else {
            return
        }
        self.append(presenter)
        presenter.attach(viperView: view)
    }
}

extension Array where Element == ViperRxPresenter {
    mutating func removePresenter(presenter: Element) {
        if let index = index(where: { ($0 as AnyObject) === (presenter as AnyObject) }) {
            presenter.detach()
            remove(at: index)
        }
    }
}
