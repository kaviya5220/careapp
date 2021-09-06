//
//  AboutTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 31/08/21.
//

import UIKit

class AboutTableViewCell: UITableViewCell,UITextViewDelegate,UITextFieldDelegate  {
            let containerView: UIStackView = {
                let stack = UIStackView()
                stack.axis = .vertical
                stack.alignment = .fill
                stack.distribution = .fillProportionally
                stack.spacing = 10
                stack.translatesAutoresizingMaskIntoConstraints = false
                return stack
            }()
            let label:CustomLabel = {
                let label = CustomLabel(labelType: .subtitle)
                label.text = "Description"
                return label
            }()
           
        let textView:UITextView = {
            let textView = UITextView()
            textView.contentInset = UIEdgeInsets(top: 0, left: -5, bottom: 5, right: 5)
           // textView.contentInsetAdjustmentBehavior = .automatic
          //  textView.center = self.view.center
    //        textView.textAlignment = NSTextAlignment.justified
            textView.isScrollEnabled = false
            textView.font = UIFont.systemFont(ofSize: 18)
           // textView.layer.borderWidth = 0
          //  textView.layer.cornerRadius = 2
            textView.layer.borderColor = UIColor.systemGray.cgColor
            //textView.textColor = UIColor.blue
            textView.backgroundColor = UIColor.white
            textView.text = ""
           
          
            //textView.text = "Enter your notes here"
           // textView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
            textView.translatesAutoresizingMaskIntoConstraints = false
            return textView
        }()
        
            override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                super.init(style: style, reuseIdentifier: reuseIdentifier)
                textView.delegate = self
                self.contentView.addSubview(containerView)
                containerView.addArrangedSubview(label)
                containerView.addArrangedSubview(textView)
                
                containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10).isActive = true
                containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
                containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
                containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
                }
            
            required init?(coder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }


