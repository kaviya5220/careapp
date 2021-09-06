//
//  quantityTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 01/09/21.
//

import UIKit

class quantityTableViewCell: UITableViewCell {

    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let quantitynameLabel:CustomLabel = {
        let label = CustomLabel(labelType: .subtitle)
        label.text = "Quantity :"
        return label
    }()
let visitedCount:CustomLabel = {
    let label = CustomLabel(labelType: .subtitle)
    label.textAlignment = .right
    return label
}()
   
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.addSubview(containerView)
        containerView.addArrangedSubview(quantitynameLabel)
        containerView.addArrangedSubview(visitedCount)
        
      //  containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
      //  containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-15).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
