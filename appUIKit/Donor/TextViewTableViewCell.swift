//
//  AddressTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 28/07/21.
//

import UIKit

class TextViewTableViewCell: UITableViewCell,UITextViewDelegate,UITextFieldDelegate {
        var selectedCountry : String = ""

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
            let label = CustomLabel(labelType: .primary)
            return label
        }()
       
    let textView:UITextView = {
        let textView = UITextView()
        textView.contentInsetAdjustmentBehavior = .automatic
      //  textView.center = self.view.center
        textView.textAlignment = NSTextAlignment.justified
        textView.isScrollEnabled = false
        textView.font = UIFont.systemFont(ofSize: 18)
        textView.layer.borderWidth = 0
        textView.layer.cornerRadius = 2
        textView.layer.borderColor = UIColor.systemGray.cgColor
        //textView.textColor = UIColor.blue
        textView.backgroundColor = UIColor.white
        textView.text = "Placeholder"
        textView.textColor = UIColor.lightGray
      
        //textView.text = "Enter your notes here"
       // textView.frame = CGRect(x: 0, y: 0, width: 200, height: 150)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    func textViewDidChange(_ textView: UITextView)
        {
        print("1")
        if textView.contentSize.height >= 30.0
            {
                textView.isScrollEnabled = true
    
            }
            else
            {
                let size = CGSize(width: contentView.frame.width, height: .infinity)
                let approxSize = textView.sizeThatFits(size)
                
                textView.constraints.forEach {(constraint) in
                    
                            if constraint.firstAttribute == .height{
                                    constraint.constant = approxSize.height
                                }
                            }
                textView.isScrollEnabled = false
            }
        }
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("2")
        if textView.textColor == UIColor.lightGray && textView == textView {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        print("3")
        if textView.text.isEmpty && textView == textView {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
        var countryList = ["BOOKS", "CLOTHES", "FOOD","ELECTRONICS"]
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            textView.delegate = self
            self.contentView.addSubview(containerView)
            containerView.addArrangedSubview(label)
            containerView.addArrangedSubview(textView)
            
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

