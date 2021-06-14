//
//  CustomButton.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

class CustomButton: UIButton {

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
    
//    func addConstraint(top: NSLayoutYAxisAnchor, left: NSLayoutXAxisAnchor, right: NSLayoutXAxisAnchor) {
//        self.topAnchor.constraint(equalTo: top, constant: 10).isActive = true
//        self.leadingAnchor.constraint(equalTo: left, constant: 10).isActive = true
//        self.trailingAnchor.constraint(equalTo: right, constant: -10).isActive = true
//        self.heightAnchor.constraint(equalToConstant: 40).isActive = true
//    }
}
