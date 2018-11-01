//
//  UIViewUtils.swift
//  Moviper
//
//  Created by marek on 29/10/2018.
//  Copyright © 2018 mtruszko. All rights reserved.
//

import UIKit

extension UIView {
    static func addAndLayoutSubview(subView: UIView,
                                    toView parentView: UIView) {
        subView.translatesAutoresizingMaskIntoConstraints = false
        parentView.addSubview(subView)
        
        let constraints = [
            NSLayoutConstraint(item: subView,
                               attribute: .height,
                               relatedBy: .equal,
                               toItem: parentView,
                               attribute: .height,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .width,
                               relatedBy: .equal,
                               toItem: parentView,
                               attribute: .width,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .centerX,
                               relatedBy: .equal,
                               toItem: parentView,
                               attribute: .centerX,
                               multiplier: 1,
                               constant: 0),
            NSLayoutConstraint(item: subView,
                               attribute: .centerY,
                               relatedBy: .equal,
                               toItem: parentView,
                               attribute: .centerY,
                               multiplier: 1,
                               constant: 0)
        ]
        
        parentView.addConstraints(constraints)
    }
}
