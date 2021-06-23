//
//  CustomLabel.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import UIKit

enum LabelType {
    case title
    case primary
    case secondary
}


class CustomLabel: UILabel {
    
    init(labelType: LabelType) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = .left
        
        switch labelType {
        
        case .title:
            self.font = UIFont.systemFont(ofSize: 24, weight: .bold)// 24 30
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
