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
                itemname.text = name
            setValue(itemdescription, name: "description", value:String(Item.item_description))
            setValue(itemlocation, name: "location", value:String(Item.address))
            setValue(itemquantity, name: "quantity", value:String(Item.item_quantity))
            donarid.text = String(Item.Donar_ID)
            setValue(visitedcount, name: "visitedcount", value:String(Item.visited_count))
            setValue(date, name: "calendar", value:Item.date)
                
            
            
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
            view.shadowOpacity = 0.3
            view.cornerRadius = 0
            view.translatesAutoresizingMaskIntoConstraints = false
            view.clipsToBounds = true
            return view
        }()
    
        let itemimage:UIImageView = {
            let img = UIImageView()
            img.image = UIImage(named:  "loadingimage")
            img.contentMode = .scaleAspectFill
            img.translatesAutoresizingMaskIntoConstraints = false
            img.layer.cornerRadius = 10
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
   
    let itemquantity:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
   
    let itemlocation:CustomLabel = {
        let label = CustomLabel(labelType:.primary)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.numberOfLines = 0
        return label
    }()
    let visitedcount:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let datelabel:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        
        
        return label
    }()
    
    let date:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
    let stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var uiimage_names : [String:String] = ["description":"doc.plaintext","quantity":"bag","visitedcount":"eye","location":"location","calendar":"calendar"]
    func setValue(_ label: UILabel,name:String,value : String){
        let attachment = NSTextAttachment()
        let imagename:String = uiimage_names[name]!
        attachment.image = UIImage(systemName: imagename)
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: value)
        attachmentString.append(myString)
        myString.append(attachmentString)
        label.attributedText = attachmentString
    }
        

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            self.customContentView.addSubview(itemimage)
            containerView.addSubview(itemname)

            containerView.addSubview(itemdescription)

            containerView.addSubview(itemquantity)

            containerView.addSubview(date)
            containerView.addSubview(stack)

            stack.addArrangedSubview(itemlocation)
           // stack.setCustomSpacing(60, after: date)
            stack.addArrangedSubview(visitedcount)

            
            self.customContentView.addSubview(containerView)
            self.contentView.addSubview(customContentView)
            
            
            itemimage.topAnchor.constraint(equalTo: self.customContentView.topAnchor, constant:15).isActive = true
            itemimage.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:15).isActive = true
            itemimage.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-15).isActive = true
            itemimage.heightAnchor.constraint(equalToConstant:150).isActive = true
          //  itemimage.bottomAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
            
            customContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            customContentView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            customContentView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
            
            containerView.topAnchor.constraint(equalTo: self.itemimage.bottomAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.customContentView.bottomAnchor, constant: -5).isActive = true
            
            stack.topAnchor.constraint(equalTo: self.date.bottomAnchor, constant:10).isActive = true
            stack.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
            stack.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
            stack.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -5).isActive = true
            
            
            itemname.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
            itemname.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemname.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//            itemdescriptionlabel.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 5).isActive = true
//            itemdescriptionlabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemdescription.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 10).isActive = true
            itemdescription.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
            
//            itemquantitylabel.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 5).isActive = true
//            itemquantitylabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            itemquantity.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 10).isActive = true
            itemquantity.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
            
//            itemlocationlabel.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
//            itemlocationlabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
            date.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 10).isActive = true
            date.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
            
            
            
//            datelabel.topAnchor.constraint(equalTo:self.itemlocation.bottomAnchor,constant: 5).isActive = true
//            datelabel.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//            date.topAnchor.constraint(equalTo:self.itemlocation.bottomAnchor,constant: 5).isActive = true
//            date.leadingAnchor.constraint(equalTo:self.datelabel.trailingAnchor,constant: 10).isActive = true
//
//            visitedcountlabel.topAnchor.constraint(equalTo:self.date.bottomAnchor,constant: 5).isActive = true
//            visitedcountlabel.leadingAnchor.constraint(equalTo:self.containerView.trailingAnchor,constant: -60).isActive = true
//            visitedcount.topAnchor.constraint(equalTo:self.date.bottomAnchor,constant: 5).isActive = true
//            visitedcount.leadingAnchor.constraint(equalTo:self.visitedcountlabel.trailingAnchor,constant: 10).isActive = true
            
//            datelabel.topAnchor.constraint(equalTo:self.stack.topAnchor,constant: 5).isActive = true
//            datelabel.leadingAnchor.constraint(equalTo:self.stack.leadingAnchor).isActive = true
//            date.topAnchor.constraint(equalTo:self.stack.topAnchor,constant: 5).isActive = true
//            date.leadingAnchor.constraint(equalTo:self.datelabel.trailingAnchor,constant: 10).isActive = true
//
//            visitedcountlabel.topAnchor.constraint(equalTo:self.stack.topAnchor,constant: 5).isActive = true
//            visitedcountlabel.leadingAnchor.constraint(equalTo:self.date.trailingAnchor).isActive = true
//            visitedcount.topAnchor.constraint(equalTo:self.stack.topAnchor,constant: 5).isActive = true
//            visitedcount.leadingAnchor.constraint(equalTo:self.visitedcountlabel.trailingAnchor,constant: 10).isActive = true
            
           // donarid.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
            //donarid.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }

    }

