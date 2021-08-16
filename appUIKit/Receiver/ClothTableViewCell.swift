//
//  ClothTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 07/08/21.
//

import UIKit

class ClothTableViewCell: UITableViewCell {

            var item: ItemDetails? {
                didSet {
                    
                    guard let Item = item else {return}
                    let name = Item.item_name
                        itemname.text = name
                    setValue(itemlocation, name: "location", value:String(Item.address))
                    setValue(visitedcount, name: "visitedcount", value:String(Item.visited_count))
                    setValue(date, name: "calendar", value:Item.date)
                    setValue(clothCategory, name: Item.description[2], value:Item.description[1])
                    setValue(size, name: "size", value:Item.description[0])
                    
                }
            }
        
       
        
            
            
            
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
            
                let clothCategory:CustomLabel = {
                    let label = CustomLabel(labelType: .primary)
                    label.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
                    return label
                }()
                
                let itemname:CustomLabel = {
                    let label = CustomLabel(labelType: .title)
                    label.font = label.font.withSize(25)
                    return label
                }()
                
                let size:CustomLabel = {
                    let label = CustomLabel(labelType: .primary)
                    label.textAlignment = .right
                    return label
                }()
           
  
            let itemlocation:UILabel = {
                let label = UILabel()
                label.lineBreakMode = .byCharWrapping
               
                  label.numberOfLines = 0
                
                label.translatesAutoresizingMaskIntoConstraints = false
                
        //        label.numberOfLines = 0
                return label
            }()
            let visitedcount:CustomLabel = {
                let label = CustomLabel(labelType: .primary)
                label.textAlignment = .right
                return label
            }()
            
            let date:CustomLabel = {
                let label = CustomLabel(labelType: .primary)
                label.textAlignment = .right
                label.textColor = .systemGray
                return label
            }()
            let stack: UIStackView = {
                let stack = UIStackView()
                stack.axis = .horizontal
                stack.alignment = .fill
                stack.distribution = .fillProportionally
                stack.spacing = 80
                stack.translatesAutoresizingMaskIntoConstraints = false
                return stack
            }()
        let firstStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .horizontal
            stack.alignment = .fill
            stack.distribution = .fillEqually
    //        stack.spacing = 80
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
      
        func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {

            let newHeight = CGFloat(16.0)
            UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return newImage!
        }
        
        var uiimage_names : [String:String] = ["male":"male","visitedcount":"eye","location":"location","calendar":"calendar","female":"female","size":"arrow.left.and.right"]
            func setValue(_ label: UILabel,name:String,value : String){
                let attachment = NSTextAttachment()
                var imagename:String = ""
                if(label == clothCategory){
                    imagename = uiimage_names[name.lowercased()]!
                    attachment.image = UIImage(named:  imagename)
                    attachment.image = resizeImage(image: attachment.image!, newWidth: 20.0)
                }
                else{
                    imagename = uiimage_names[name]!
                    attachment.image = UIImage(systemName: imagename) }
                let attachmentString = NSMutableAttributedString(attachment: attachment)
                let myString = NSMutableAttributedString(string: " "+value)
                attachmentString.append(myString)
                myString.append(attachmentString)
                label.attributedText = attachmentString
            }
           
                override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
                    super.init(style: style, reuseIdentifier: reuseIdentifier)
                    
                   // itemlocation.numberOfLines = countLines(of: itemlocation, maxHeight: 180)
                    self.customContentView.addSubview(itemimage)
                    containerView.addArrangedSubview(stack)


                    containerView.addArrangedSubview(stack)
                    containerView.addArrangedSubview(firstStack)
                    containerView.addArrangedSubview(itemlocation)
                    
                    containerView.addArrangedSubview(date)
                    

                    stack.addArrangedSubview(itemname)
                    stack.addArrangedSubview(visitedcount)
                    
                    firstStack.addArrangedSubview(clothCategory)
                    firstStack.addArrangedSubview(size)

                    
                    self.customContentView.addSubview(containerView)
                    self.contentView.addSubview(customContentView)
                    
                    
                    itemimage.topAnchor.constraint(equalTo: self.customContentView.topAnchor, constant:15).isActive = true
                    itemimage.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:15).isActive = true
                    itemimage.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-15).isActive = true
                    itemimage.heightAnchor.constraint(equalToConstant:300).isActive = true
                    
                    customContentView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant:5).isActive = true
                    customContentView.leadingAnchor.constraint(equalTo:self.contentView.leadingAnchor, constant:10).isActive = true
                    customContentView.trailingAnchor.constraint(equalTo:self.contentView.trailingAnchor, constant:-10).isActive = true
                    customContentView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5).isActive = true
                    
                    containerView.topAnchor.constraint(equalTo: self.itemimage.bottomAnchor, constant:5).isActive = true
                    containerView.leadingAnchor.constraint(equalTo:self.customContentView.leadingAnchor, constant:15).isActive = true
                    containerView.trailingAnchor.constraint(equalTo:self.customContentView.trailingAnchor, constant:-15).isActive = true
                    containerView.bottomAnchor.constraint(equalTo: self.customContentView.bottomAnchor, constant: -15).isActive = true
                    
                
                    
                    
                
                  
                }
                
                required init?(coder aDecoder: NSCoder) {
                    
                    super.init(coder: aDecoder)
                }

            }





