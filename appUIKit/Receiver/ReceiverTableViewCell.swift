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
            setValue(itemlocation, name: "location", value:String(Item.address))
            setValue(itemCategory, name: "category", value:String(Item.category))
            donarid.text = String(Item.Donar_ID)
            setValue(visitedcount, name: "visitedcount", value:String(Item.visited_count))
            setValue(date, name: "calendar", value:Item.date)
        }
    }
    
    
        
//        let containerView:UIView = {
//            let view = UIView()
//            view.translatesAutoresizingMaskIntoConstraints = false
//            view.clipsToBounds = true
//            return view
//        }()
    
    let containerView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillProportionally
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
   
    let itemCategory:CustomLabel = {
        let label = CustomLabel(labelType: .primary)
        return label
    }()
   
    let itemlocation:UILabel = {
        let label = UILabel()
      //  label.
        label.lineBreakMode = .byCharWrapping
       // label.sizeToFit()
         //label.adjustsFontSizeToFitWidth = true
          label.numberOfLines = 0
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
//        label.numberOfLines = 0
        return label
    }()
    let visitedcount:CustomLabel = {
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
        stack.alignment = .lastBaseline
        stack.distribution = .fillProportionally
        stack.spacing = 80
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    var uiimage_names : [String:String] = ["description":"doc.plaintext","category":"bag","visitedcount":"eye","location":"location","calendar":"calendar"]
    func setValue(_ label: UILabel,name:String,value : String){
        let attachment = NSTextAttachment()
        let imagename:String = uiimage_names[name]!
        attachment.image = UIImage(systemName: imagename)
        let attachmentString = NSMutableAttributedString(attachment: attachment)
        let myString = NSMutableAttributedString(string: " "+value)
        attachmentString.append(myString)
        myString.append(attachmentString)
        label.attributedText = attachmentString
    }
    func countLines(of label: UILabel, maxHeight: CGFloat) -> Int {
            // viewDidLayoutSubviews() in ViewController or layoutIfNeeded() in view subclass
            guard let labelText = label.text else {
                return 0
            }
            
            let rect = CGSize(width: label.bounds.width, height: maxHeight)
            let labelSize = labelText.boundingRect(with: rect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: label.font!], context: nil)
            
            let lines = Int(ceil(CGFloat(labelSize.height) / label.font.lineHeight))
            return labelText.contains("\n") && lines == 1 ? lines + 1 : lines
       }
     
    // maxHeight is just an example. It needs to be calculated dynamically for all screen sizes.
  //

        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
           // itemlocation.numberOfLines = countLines(of: itemlocation, maxHeight: 180)
            self.customContentView.addSubview(itemimage)
            containerView.addArrangedSubview(itemname)

            containerView.addArrangedSubview(itemdescription)

            containerView.addArrangedSubview(itemCategory)

            containerView.addArrangedSubview(itemlocation)
            containerView.addArrangedSubview(stack)

            stack.addArrangedSubview(date)
           // stack.setCustomSpacing(60, after: date)
            stack.addArrangedSubview(visitedcount)

            
            self.customContentView.addSubview(containerView)
            self.contentView.addSubview(customContentView)
            
            
            itemimage.topAnchor.constraint(equalTo: self.customContentView.topAnchor, constant:15).isActive = true
            itemimage.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:15).isActive = true
            itemimage.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-15).isActive = true
            itemimage.heightAnchor.constraint(equalToConstant:150).isActive = true
            
            customContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
            customContentView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
            customContentView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
            customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
            
            containerView.topAnchor.constraint(equalTo: self.itemimage.bottomAnchor, constant:5).isActive = true
            containerView.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:10).isActive = true
            containerView.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-10).isActive = true
            containerView.bottomAnchor.constraint(equalTo: self.customContentView.bottomAnchor, constant: -15).isActive = true
            
            
          //  stack.leadingAnchor
            
        //    stack.topAnchor.constraint(equalTo: self.itemlocation.bottomAnchor, constant:-10).isActive = true
//            stack.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor, constant:10).isActive = true
//            stack.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor, constant:-10).isActive = true
//            stack.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -5).isActive = true
            
            
//            itemname.topAnchor.constraint(equalTo:self.containerView.topAnchor,constant: 15).isActive = true
//            itemname.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor).isActive = true
//            itemname.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//            itemdescription.topAnchor.constraint(equalTo:self.itemname.bottomAnchor,constant: 10).isActive = true
//            itemdescription.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
//
//
//            itemquantity.topAnchor.constraint(equalTo:self.itemdescription.bottomAnchor,constant: 10).isActive = true
//            itemquantity.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
//
////            itemlocationlabel.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 5).isActive = true
//            itemlocation.trailingAnchor.constraint(equalTo:self.containerView.trailingAnchor).isActive = true
//            itemlocation.topAnchor.constraint(equalTo:self.itemquantity.bottomAnchor,constant: 10).isActive = true
//            itemlocation.leadingAnchor.constraint(equalTo:self.containerView.leadingAnchor,constant: 10).isActive = true
//            itemlocation.bottomAnchor.constraint(equalTo:self.stack.topAnchor).isActive = true
            
            
        
          
        }
        
        required init?(coder aDecoder: NSCoder) {
            
            super.init(coder: aDecoder)
        }

    }

