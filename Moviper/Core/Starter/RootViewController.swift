//
//  RootViewController.swift
//  Moviper
//
//  Created by marek on 29/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

var rootViewController: UIViewController? {
    get {
        return UIApplication.shared.keyWindow?.rootViewController
    }
    set(newRoot) {
        UIApplication.shared.keyWindow?.rootViewController = newRoot
    }
}
