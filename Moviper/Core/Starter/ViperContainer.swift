//
//  ViperContainer.swift
//  Moviper
//
//  Created by marek on 29/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

public protocol ViperContainer {
    func inject(container: ContainerView,
                destinatinViewController: UIViewController,
                animated: Bool,
                completed: (() -> ())?)
}

extension ViperContainer {
    func inject(container: ContainerView,
                destinatinViewController: UIViewController,
                animated: Bool = true,
                completed: (() -> ())? = nil) {
        inject(container: container,
               destinatinViewController: destinatinViewController,
               animated: animated,
               completed: completed)
    }
}

extension UIViewController: ViperContainer { }

extension ViperContainer where Self: UIViewController {
    public func inject(container: ContainerView,
                destinatinViewController: UIViewController,
                animated: Bool,
                completed: (() -> ())? = nil) {
        cycle(witchContainerView: container,
              toChildViewController: destinatinViewController,
              animated: animated,
              completion: completed)
    }
}

extension UIViewController {
    func cycle(witchContainerView containerView: ContainerView,
               toChildViewController newViewController: UIViewController,
               animated: Bool = true,
               completion: (() -> ())? = nil) {
        
        let oldViewController = containerView.currentViewController
        oldViewController?.willMove(toParent: nil)
        oldViewController?.beginAppearanceTransition(false, animated: animated)
        newViewController.beginAppearanceTransition(true, animated: animated)
        addChild(newViewController)
        newViewController.endAppearanceTransition()
        containerView.currentViewController = newViewController
        
        UIView.addAndLayoutSubview(subView: newViewController.view, toView: containerView)
        
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        
        UIView.animate(withDuration: animated ? 0.5 : 0,
                       animations: {
                        newViewController.view.alpha = 1
                        oldViewController?.view.alpha = 0
        },
                       completion: { _ in
                        oldViewController?.view.removeFromSuperview()
                        oldViewController?.removeFromParent()
                        oldViewController?.endAppearanceTransition()
                        newViewController.didMove(toParent: self)
                        newViewController.endAppearanceTransition()
                        completion?()
        })
    }
}
