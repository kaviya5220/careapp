//
//  CategoryTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 28/07/21.
//

import UIKit
class CategoryTableViewCell: UITableViewCell {
    var selectedCategory = ""
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    
   
    
    let itemCategoryLabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.textAlignment = .left
        label.text = "Category"
        return label
    }()
    
    let categoryButton:UIButton = {
        let button = UIButton()
        button.setTitle("Select a category", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .left
        
       return button
    }()
    
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(containerView)
        self.containerView.addArrangedSubview(itemCategoryLabel)
       
        self.containerView.addArrangedSubview(categoryButton)

        
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor,constant: 10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
