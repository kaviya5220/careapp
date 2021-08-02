//
//  CategoryTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 28/07/21.
//

import UIKit
protocol passCategory{
    func passCategory(category : String)
}
class CategoryTableViewCell: UITableViewCell {
    var selectedCategory = ""
    var delegate : passCategory?
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        categoryButton.isHidden = false
        let cell = tableView.cellForRow(at: indexPath)
        categoryButton.setTitle(cell?.textLabel?.text, for: .normal)
        delegate?.passCategory(category: (cell?.textLabel?.text)!)
        tableExpanded = false
    }
    
   
    var tableExpanded : Bool = false
    
    let itemCategoryLabel:UILabel = {
        let label = CustomLabel(labelType: .primary)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.text = "Category"
        return label
    }()
    var countryList = ["BOOKS", "CLOTHES", "FOOD","ELECTRONICS"]
    
    let categoryButton:UIButton = {
        let button = CustomButton(title: "Select a Category", bgColor: .white)
        button.backgroundColor = .white
        button.setTitleColor(.systemBlue, for: .normal)
        button.layer.cornerRadius = 10
        button.contentHorizontalAlignment = .left
       return button
    }()
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
     
        self.contentView.addSubview(containerView)
        self.containerView.addArrangedSubview(itemCategoryLabel)
       
        self.containerView.addArrangedSubview(categoryButton)
//        containerView.addArrangedSubview(itemCategoryLabel)
//        containerView.addArrangedSubview(category)
    
        
        
//        categoryTableView.topAnchor.constraint(equalTo:self.contentView.topAnchor,constant: <#T##CGFloat#>).isActive = true
//        categoryTableView.leftAnchor.constraint(equalTo:self.contentView.leftAnchor).isActive = true
//        categoryTableView.rightAnchor.constraint(equalTo:self.contentView.rightAnchor).isActive = true
//        categoryTableView.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
//
//
//        categoryButton.topAnchor.constraint(equalTo:self.contentView.topAnchor).isActive = true
//        categoryButton.leftAnchor.constraint(equalTo:self.contentView.leftAnchor).isActive = true
//        categoryButton.rightAnchor.constraint(equalTo:self.contentView.rightAnchor).isActive = true
//        categoryButton.bottomAnchor.constraint(equalTo:self.contentView.bottomAnchor).isActive = true
        
        containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
