//
//  BaseRxTabBarController.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit
import RxSwift

open class BaseRxTabBarController: UITabBarController, ViperRxView {
    
    private var disposeBag = DisposeBag()
    public var presenters: [ViperRxPresenter] = []
    private var isAttached = false
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        
        presenters = createPresenters()
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        attachIfNeeded()
    }
    
    deinit {
        detach()
        presenters.removeAll()
    }
    
    public func attachIfNeeded() {
        guard !isAttached else {
            return
        }
        isAttached = true
        for presenter in presenters {
            presenter.attach(viperView: self)
        }
    }
    
    public func detach() {
        isAttached = false
        for presenter in presenters {
            presenter.detach()
        }
    }
    
    public func addSubscription(subscription: Disposable?) {
        if let subscription = subscription {
            disposeBag.insert(subscription)
        }
    }
    
    open func createPresenters() -> [ViperRxPresenter] {
        preconditionFailure("This method must be overridden")
    }
}

