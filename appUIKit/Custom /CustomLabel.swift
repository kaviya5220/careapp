//
//  CustomLabel.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

enum LabelType {
    case Title
    case title
    case subtitle
    case primary
    case secondary
}


class CustomLabel: UILabel {
    
    init(labelType: LabelType) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
      //  self.lineBreakMode = .byWordWrapping
       // self.adjustsFontSizeToFitWidth = true
      //  self.numberOfLines = 0
        
        switch labelType {
        case .Title:
            self.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        case .title:
            self.font = UIFont.systemFont(ofSize: 24, weight: .bold)// 24 30
        case .subtitle :
            self.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        case .primary:
            self.font = UIFont.systemFont(ofSize: 16, weight: .semibold)//16 17
        case .secondary:
            self.font = UIFont.systemFont(ofSize: 14, weight: .regular)//12 or 14
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
