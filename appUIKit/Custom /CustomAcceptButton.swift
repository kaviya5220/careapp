//
//  CustomAcceptButton.swift
//  appUIKit
//
//  Created by sysadmin on 14/07/21.
//

import UIKit

class CustomAcceptButton: UIButton {
    var row : Int?
    var section : Int?

        init(title: String, bgColor: UIColor) {
            super.init(frame: .zero)
            self.setTitle(title, for: .normal)
            addFeatures(bgColor: bgColor)
        }
        
        private func addFeatures(bgColor: UIColor) {
            self.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.backgroundColor = bgColor
            self.layer.cornerRadius = 8
            self.contentEdgeInsets = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
            self.translatesAutoresizingMaskIntoConstraints = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
}
