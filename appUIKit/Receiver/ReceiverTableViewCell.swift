//
//  ReceiverTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import UIKit

class ReceiverTableViewCell: UITableViewCell {
    var item: Item? {
        didSet {
            guard let Item = item else {return}
            let name = Item.item_name
                itemimage.image = UIImage(systemName: "person")
                itemname.text = name
                itemdescription.text = Item.item_description
                itemquantity.text = Item.item_quantity
                donarid.text = String(Item.Donar_ID)
            
        }
    }
        
        let containerView:UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
        
        let itemimage:UIImageView = {
            let img = UIImageView()
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 35
            img.clipsToBounds = true
            return img
        }()
    
        let donarid:CustomLabel = {
            let label = CustomLabel(labelType: .secondary)
            return label
        }()
        
        let itemname:CustomLabel = {
            let label = CustomLabel(labelType: .secondary)
            return label
        }()
        
        let itemdescription:CustomLabel = {
            let label = CustomLabel(labelType: .secondary)
            return label
        }()
    
    let itemquantity:CustomLabel = {
        let label = CustomLabel(labelType: .secondary)
        return label
    }()
        

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.contentView.addSubview(itemimage)
            containerView.addSubview(itemname)
            containerView.addSubview(itemdescription)
            containerView.addSubview(itemquantity)
            containerView.addSubview(donarid)

            
            self.contentView.addSubview(containerView)
            
            itemimage.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:20).isActive = true
            itemimage.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            itemimage.widthAnchor.constraint(equalToConstant:70).isActive = true
            itemimage.heightAnchor.constraint(equalToConstant:70).isActive = true
            
            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.itemimage.trailingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.heightAnchor.constraint(equalToConstant:150).isActive = true
            
            itemname.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
            itemname.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemname.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
           
            itemdescription.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 5).isActive = true
            itemdescription.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            
            itemquantity.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 5).isActive = true
            itemquantity.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            
            donarid.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
            donarid.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }

    }

