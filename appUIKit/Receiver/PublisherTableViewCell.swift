//
//  PublisherTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 31/08/21.
//

import UIKit

class PublisherTableViewCell: UITableViewCell {
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    let publisherNameLabel:CustomLabel = {
        let label = CustomLabel(labelType: .subtitle)
        label.text = ""
        return label
    }()
let publishingyearLabel:CustomLabel = {
    let label = CustomLabel(labelType: .subtitle)
    label.text = ""
    label.textAlignment = .right
    return label
}()
   
  
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
        self.contentView.addSubview(containerView)
        containerView.addArrangedSubview(publisherNameLabel)
        containerView.addArrangedSubview(publishingyearLabel)
        
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

   
