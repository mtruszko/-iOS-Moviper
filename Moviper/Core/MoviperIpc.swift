//
//  MoviperIpc.swift
//  Moviper
//
//  Created by marek on 27/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import Foundation
import RxSwift

private struct MoviperBundle {
    let presenter: ViperRxPresenter
    let register: Bool
}

public class Moviper {
    public static let DEFAULT_NAME = "defaultPresenteName"
    
    public static var sharedInstance = Moviper()
    
    let disposeBag = DisposeBag()
    let ipcConcurrentQueue = DispatchQueue(label: "IpcQueue")
    
    private var presenters = [ViperRxPresenter]()
    private let registerSynchronizer = PublishSubject<MoviperBundle>()
    
    private init() {
        registerSynchronizer
            .observeOn(SerialDispatchQueueScheduler(queue: ipcConcurrentQueue, internalSerialQueueName: "IpcQueue"))
            .subscribe(onNext: { moviperBundle in
                self.route(moviperBundle: moviperBundle)
            }).disposed(by: disposeBag)
    }
    
    private func route(moviperBundle: MoviperBundle) {
        if moviperBundle.register {
            self.registerSync(presenter: moviperBundle.presenter)
        } else {
            self.unregisterSync(presenter: moviperBundle.presenter)
        }
    }
    
    private func registerSync(presenter: ViperRxPresenter) {
        presenters.append(presenter)
    }
    
    private func unregisterSync(presenter: ViperRxPresenter) {
        let index =  self.presenters.index { (containedPresenter) -> Bool in
            containedPresenter.identifier == presenter.identifier
        }
        
        if let index = index {
            self.presenters.remove(at: index)
        }
    }
    
    func register(presenter: ViperRxPresenter) {
        registerSynchronizer.onNext(MoviperBundle(presenter: presenter, register: true))
    }
    
    func unregister(presenter: ViperRxPresenter) {
        registerSynchronizer.onNext(MoviperBundle(presenter: presenter, register: false))
    }
    
    private func getPresenters<T: ViperRxPresenter>(presenterType: T.Type) -> Observable<T> {
        return Observable.from(presenters)
            .filter { (presenter: ViperRxPresenter) in
                type(of: presenter) == presenterType
            }
            .map { presenter in
                return presenter as! T
            }
            .subscribeOn(MainScheduler.instance)
    }
    
    public func getPresenterInstance<T: ViperRxPresenter>(presenterType: T.Type, presenterName: String = DEFAULT_NAME) -> Maybe<T> {
        return getPresenters(presenterType: presenterType)
            .filter { (presenter: ViperRxPresenter) in
                presenter.name == presenterName
            }
            .asMaybe()
    }
    
    public func getPresenterInstanceOrError<T: ViperRxPresenter>(presenterType: T.Type, presenterName: String = DEFAULT_NAME) -> Single<T> {
        return getPresenters(presenterType: presenterType)
            .filter { (presenter: ViperRxPresenter) in
                presenter.name == presenterName
            }
            .asSingle()
    }
}
