//
//  CustomTextField.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

class CustomTextField: UITextField {

    
        let padding = UIEdgeInsets(top: 0, left: 15, bottom: 5, right: 5)
        
        init() {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.borderWidth = 1.5
            self.layer.borderColor = UIColor.systemGray.cgColor
//            let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: 5)
//            self.layer.shadowColor = UIColor.black.cgColor
//            self.layer.shadowOffset = CGSize(width: 0, height: 2)
//            self.layer.shadowOpacity = 1
//            self.layer.shadowPath = shadowPath.cgPath
            self.backgroundColor = UIColor.white
            self.layer.cornerRadius = 5
            self.autocorrectionType = .no
        }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
