//
//  YearTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 18/08/21.
//

import UIKit

class QuantityTableViewCell: UITableViewCell {
    let myUIStepper = UIStepper()
    var categoryClicked: String? {
        didSet {
            label.text = categoryClicked
        }
    }
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
   
    let label:CustomLabel = {
        let field = CustomLabel(labelType: .primary)
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
        myUIStepper.wraps = false
               
            
               // If tap and hold the button, UIStepper value will continuously increment
               myUIStepper.autorepeat = true
               
               // Set UIStepper max value to 10
               myUIStepper.maximumValue = 50
               myUIStepper.minimumValue = 1
               
               // Add a function handler to be called when UIStepper value changes
              
               
             
        self.contentView.addSubview(stackView)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.addArrangedSubview(myUIStepper)
        
        stackView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
        stackView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



  
