//
//  AddItemTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 26/07/21.
//

import UIKit

class AddItemTableViewCell: UITableViewCell {

    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let donarid:CustomLabel = {
        let label = CustomLabel(labelType: .secondary)
        label.text = ""
        return label
    }()
    let itemname:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(itemname)
       // containerView.addArrangedSubview(donarid)
       // containerView.addArrangedSubview(itemname)
        
        itemname.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        itemname.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        itemname.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        itemname.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
