//
//  Extension.swift
//  appUIKit
//
//  Created by sysadmin on 14/06/21.
//

import Foundation
import UIKit.UITraitCollection

extension UIViewController {
    
func layoutTraitConstraintsUpdate(traitCollection:UITraitCollection, sharedConstraints: [NSLayoutConstraint], compactConstraints: [NSLayoutConstraint], regularConstraints: [NSLayoutConstraint]) {
    
    if sharedConstraints.count > 0 && sharedConstraints[0].isActive == false {
        NSLayoutConstraint.activate(sharedConstraints)
    }
    
    if traitCollection.horizontalSizeClass == .compact && traitCollection.verticalSizeClass == .regular {
        if regularConstraints.count > 0 && regularConstraints[0].isActive {
            NSLayoutConstraint.deactivate(regularConstraints)
        }
        NSLayoutConstraint.activate(compactConstraints)
    }
    else {
        if compactConstraints.count > 0 && compactConstraints[0].isActive {
            NSLayoutConstraint.deactivate(compactConstraints)
        }
        NSLayoutConstraint.activate(regularConstraints)
    }
}
}
