//
//  TextFieldTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 03/08/21.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.textColor = .black
       // label.text = "Item Name"
        return label
    }()
    let label1:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.textColor = .systemBlue
       // label.text = "Item Name"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.addSubview(containerView)
        containerView.addArrangedSubview(label)
        containerView.addArrangedSubview(label1)
        
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

   

}
