//
//  ViperNavigator.swift
//  Moviper
//
//  Created by marek on 29/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

public protocol ViperNavigator {
    func push(destinationViewController: UIViewController,
              animated: Bool)
    func presentOnTopView(destinationViewController: UIViewController,
                          animated: Bool)
}

extension UIViewController: ViperNavigator { }

extension ViperNavigator where Self: UIViewController {
    var topVC: UIViewController? {
        return rootViewController
    }
    
    public func push(destinationViewController: UIViewController,
              animated: Bool ) {
        self.navigationController?.pushViewController(destinationViewController,
                                                      animated: animated)
    }
    
    public func presentOnTopView(destinationViewController: UIViewController,
                          animated: Bool) {
        self.present(destinationViewController: destinationViewController,
                     animated: animated)
    }
    
    func present(destinationViewController: UIViewController,
                 animated: Bool) {
        topVC?.present(UINavigationController(rootViewController: destinationViewController),
                       animated: animated,
                       completion: nil)
    }
}
