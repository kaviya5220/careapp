//
//  CustomTextField.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

class CustomTextField: UITextField {

    
        let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        init() {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.layer.borderWidth = 1
            self.layer.borderColor = UIColor.white.cgColor
            self.backgroundColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1.00)
            self.layer.cornerRadius = 5
            self.autocorrectionType = .no
        }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
