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
            self.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        case .primary:
            self.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        case .secondary:
            self.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
