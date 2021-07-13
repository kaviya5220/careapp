//
//  DonarTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import UIKit

class DonarTableViewCell: UITableViewCell {
    let horizontalstackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        //stack.spacing = 15
        stack.backgroundColor = .white
        stack.layer.cornerRadius = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let label_name:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.textAlignment = .left
        return label
    }()
    let label_value:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.textAlignment = .right
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(horizontalstackView)
        horizontalstackView.addArrangedSubview(label_name)
        horizontalstackView.addArrangedSubview(label_value)
        
        

        horizontalstackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
        horizontalstackView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant: 5).isActive = true
        horizontalstackView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: -5).isActive = true
        horizontalstackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   

}
