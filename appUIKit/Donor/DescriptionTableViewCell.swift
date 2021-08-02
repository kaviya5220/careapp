//
//  DescriptionTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 30/07/21.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell {
    var categoryClicked: String? {
        didSet {
            label.text = categoryClicked
        }
    }
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    let label:CustomLabel = {
        let field = CustomLabel(labelType: .primary)
        field.text = "Enter name"
        return field
    }()
    let textField:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
   
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(stackView)
//        stackView.addArrangedSubview(author)
//        stackView.addArrangedSubview(author)
//        stackView.addArrangedSubview(publisher)
//        stackView.addArrangedSubview(yearofpublisher)
//        stackView.addArrangedSubview(Quantity)
//        stackView.addArrangedSubview(itemDescription)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        stackView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


