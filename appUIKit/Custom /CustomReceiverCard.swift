//
//  CustomReceiverCard.swift
//  appUIKit
//
//  Created by sysadmin on 19/06/21.
//

import UIKit

class CustomReceiverCard: UIView {

        open var cornerRadius: CGFloat = 2
        
    open var shadowOffsetWidth: Int = 0
    open var shadowOffsetHeight: Int = 1
        open var shadowColor: UIColor? = UIColor.black
        open var shadowOpacity: Float = 0
        
        override open func layoutSubviews() {
            
            layer.cornerRadius = cornerRadius
            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
            layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            layer.borderWidth = 2
            layer.cornerRadius = 10
            layer.masksToBounds = false
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight)
            layer.shadowOpacity = shadowOpacity
            layer.shadowPath = shadowPath.cgPath
        }
        
}

