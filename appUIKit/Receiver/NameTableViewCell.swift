//
//  NameTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 31/08/21.
//

import UIKit

class NameTableViewCell: UITableViewCell {
        let containerView: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.alignment = .fill
            stack.distribution = .fillEqually
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        let bookNameLabel:CustomLabel = {
            let label = CustomLabel(labelType: .Title)
            label.textAlignment = .center
            return label
        }()
    let authorNameLabel:CustomLabel = {
        let label = CustomLabel(labelType: .title)
        label.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        label.textAlignment = .center
        return label
    }()
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
           
            self.contentView.addSubview(containerView)
            containerView.addArrangedSubview(bookNameLabel)
            containerView.addArrangedSubview(authorNameLabel)
            
           // containerView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive = true
            //containerView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
