//
//  RequestListTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 05/07/21.
//

import UIKit


class RequestListTableViewCell: UITableViewCell {
    
    var request: RequestList? {
        didSet {
            guard let Request = request else {return}
         
            receiver_name.text = Request.receiver_name
            receiver_Phone.text = Request.receiver_phone
            receiver_email.text = Request.receiver_email
            receiver_Address.text = Request.receiver_address
           
           
            
        }
    }
        
        let containerView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let customContentView:UIView = {
            let view = CustomReceiverCard()
            view.backgroundColor = UIColor.white
            view.shadowOpacity = 0.4
            view.cornerRadius = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
    let receiver_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Receiver"
        label.textAlignment = .center
        return label
    }()
    
    let receivername_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Name:"
        return label
    }()
        let receiver_name:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
        }()
    let receiveraddress_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Address:"
        return label
    }()
        
        let receiver_Address:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
        }()
    let receiverphone_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Phone:"
        return label
    }()
        
        let receiver_Phone:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
         
        }()
    
    let receiveremail_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Email:"
        return label
    }()
        
        let receiver_email:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
        }()
    let swipe_label:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Swipe to Accept >>"
        label.textColor = #colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1)
        return label
    }()
    
    
   

        

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            containerView.addSubview(receiver_label)
            containerView.addSubview(receivername_label)
            containerView.addSubview(receiver_name)
            containerView.addSubview(receiverphone_label)
            containerView.addSubview(receiver_Phone)
            containerView.addSubview(receiveremail_label)
            containerView.addSubview(receiver_email)
            containerView.addSubview(receiveraddress_label)
            containerView.addSubview(receiver_Address)
            containerView.addSubview(swipe_label)
            self.contentView.addSubview(containerView)
            
            
            

            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
            
            receiver_label.topAnchor.constraint(equalTo:self.containerView.topAnchor).isActive = true
            receiver_label.centerXAnchor.constraint(equalTo: self.containerView.centerXAnchor).isActive = true
            
            receivername_label.topAnchor.constraint(equalTo:self.receiver_label.bottomAnchor,constant: 5).isActive = true
            receivername_label.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_name.topAnchor.constraint(equalTo:self.receiver_label.bottomAnchor,constant: 5).isActive = true
            receiver_name.leadingAnchor.constraint(equalTo:self.receivername_label.trailingAnchor,constant: 10).isActive = true
            
            receiverphone_label.topAnchor.constraint(equalTo:self.receiver_name.bottomAnchor,constant: 5).isActive = true
            receiverphone_label.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_Phone.topAnchor.constraint(equalTo:self.receiver_name.bottomAnchor,constant: 5).isActive = true
            receiver_Phone.leadingAnchor.constraint(equalTo:self.receiverphone_label.trailingAnchor,constant: 10).isActive = true
            
            receiveremail_label.topAnchor.constraint(equalTo:self.receiver_Phone.bottomAnchor,constant: 5).isActive = true
            receiveremail_label.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_email.topAnchor.constraint(equalTo:self.receiver_Phone.bottomAnchor,constant: 5).isActive = true
            receiver_email.leadingAnchor.constraint(equalTo:self.receiveremail_label.trailingAnchor,constant: 10).isActive = true
            
            receiveraddress_label.topAnchor.constraint(equalTo:self.receiver_email.bottomAnchor,constant: 5).isActive = true
            receiveraddress_label.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_Address.topAnchor.constraint(equalTo:self.receiver_email.bottomAnchor,constant: 5).isActive = true
            receiver_Address.leadingAnchor.constraint(equalTo:self.receiveraddress_label.trailingAnchor,constant: 10).isActive = true
            
            swipe_label.topAnchor.constraint(equalTo:self.receiver_Address.bottomAnchor,constant: 5).isActive = true
            swipe_label.leadingAnchor.constraint(equalTo:self.contentView.trailingAnchor,constant: -160).isActive = true
            
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }
    }


