//
//  DonationTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 02/07/21.
//

import UIKit

class DonationTableViewCell: UITableViewCell {
    
    var item: Item? {
        didSet {
            guard let Item = item else {return}
            let name = Item.item_name
                itemimage.image = UIImage(named: "dnimge")
                itemname.text = name
                itemdescription.text = Item.item_description
                itemquantity.text = Item.item_quantity
                donarid.text = String(Item.Donar_ID)
                visitedcount.text = String(Item.visited_count)
                date.text = Item.date
            
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
            let label = CustomLabel(labelType: .title)
            label.font = label.font.withSize(25)
            return label
        }()
        
        let itemdescription:CustomLabel = {
            let label = CustomLabel(labelType: .primary)
            return label
        }()
    let itemdescriptionlabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Description :"
        return label
    }()
    
    let itemquantity:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let itemquantitylabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Quantity :"
        return label
    }()
    
    let visitedcountlabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        label.text = "Visted Count :"
        return label
    }()
    let visitedcount:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        
        return label
    }()
    let datelabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        let attachment = NSTextAttachment()
        attachment.image = UIImage(systemName: "calendar")
        let attachmentString = NSAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: "Date  ")
        myString.append(attachmentString)
        label.attributedText = myString
        return label
    }()
    
    let date:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
       
        return label
    }()
    
        

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
          
            containerView.addSubview(itemname)
            containerView.addSubview(itemdescriptionlabel)
            containerView.addSubview(itemdescription)
            containerView.addSubview(itemquantitylabel)
            containerView.addSubview(itemquantity)
            containerView.addSubview(datelabel)
            containerView.addSubview(date)
            containerView.addSubview(visitedcountlabel)
            containerView.addSubview(visitedcount)

            self.contentView.addSubview(containerView)
            
            

            containerView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
            
            
            itemname.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
            itemname.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemname.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
            itemdescriptionlabel.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 5).isActive = true
            itemdescriptionlabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemdescription.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 5).isActive = true
            itemdescription.leadingAnchor.constraint(equalTo:self.itemdescriptionlabel.trailingAnchor,constant: 10).isActive = true
            
            itemquantitylabel.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 5).isActive = true
            itemquantitylabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemquantity.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 5).isActive = true
            itemquantity.leadingAnchor.constraint(equalTo:self.itemquantitylabel.trailingAnchor,constant: 10).isActive = true
            
            datelabel.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
            datelabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            date.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
            date.leadingAnchor.constraint(equalTo:self.datelabel.trailingAnchor,constant: 10).isActive = true
            
            visitedcountlabel.topAnchor.constraint(equalTo:self.date.bottomAnchor,constant: 5).isActive = true
            visitedcountlabel.leadingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -140).isActive = true
            visitedcount.topAnchor.constraint(equalTo:self.date.bottomAnchor,constant: 5).isActive = true
            visitedcount.leadingAnchor.constraint(equalTo:self.visitedcountlabel.trailingAnchor,constant: 10).isActive = true
            
           
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }

    }

