//
//  AddItemTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 26/07/21.
//

import UIKit

class ItemNameTableViewCell: UITableViewCell {
    
    var selectedCountry : String = ""

    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let itemNameLabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Item Name"
        return label
    }()
    let itemname:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
    let itemCategoryLabel:CustomLabel = {
        let label = CustomLabel(labelType: .secondary)
        label.text = "Category"
        return label
    }()
    var countryList = ["BOOKS", "CLOTHES", "FOOD","ELECTRONICS"]
//    let itemNameLabel:CustomLabel = {
//        let label = CustomLabel(labelType: .secondary)
//        label.text = "Item Name"
//        return label
//    }()
    let category:UITextField = {
        let namefield = UITextField()
        namefield.placeholder = "Enter Item Name"
        namefield.borderStyle = .none
        namefield.translatesAutoresizingMaskIntoConstraints = false
        return namefield
    }()
//    let itemNameLabel:CustomLabel = {
//        let label = CustomLabel(labelType: .secondary)
//        label.text = "Item Name"
//        return label
//    }()
//    let itemname:UITextField = {
//        let namefield = UITextField()
//        namefield.placeholder = "Enter Item Name"
//        namefield.borderStyle = .none
//        namefield.translatesAutoresizingMaskIntoConstraints = false
//        return namefield
//    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.addSubview(containerView)
        containerView.addArrangedSubview(itemNameLabel)
        containerView.addArrangedSubview(itemname)
        
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
