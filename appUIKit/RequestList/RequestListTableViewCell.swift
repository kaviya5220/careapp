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
         
            receiver_name.text = Request.user_name
            receiver_Address.text = Request.item_address
            item_name.text = Request.item_name
            
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
    
        
        let receiver_name:CustomLabel = {
            let label = CustomLabel(labelType: .title)
            label.font = label.font.withSize(25)
            return label
        }()
        
        let receiver_Address:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
        }()
//    let itemdescriptionlabel:CustomLabel = {
//        let label = CustomLabel(labelType: .primary)
//        label.text = "Description :"
//        return label
//    }()
    
    let item_name:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
   
        

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
          
            containerView.addSubview(receiver_name)
           
            containerView.addSubview(receiver_Address)
            
            containerView.addSubview(item_name)
            

            self.contentView.addSubview(containerView)
            
            

            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
            
            
            receiver_name.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
            receiver_name.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_name.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
           
            receiver_Address.topAnchor.constraint(equalTo:self.receiver_name.bottomAnchor,constant: 5).isActive = true
            receiver_Address.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            receiver_Address.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
           
           
            item_name.topAnchor.constraint(equalTo:self.receiver_Address.bottomAnchor,constant: 5).isActive = true
            item_name.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            item_name.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
           // item_name.leadingAnchor.constraint(equalTo:self..trailingAnchor,constant: 10).isActive = true
            
            
            
           
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }

    }

