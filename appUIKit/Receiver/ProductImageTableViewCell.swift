//
//  ProductImageTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 31/08/21.
//

import UIKit

class ProductImageTableViewCell: UITableViewCell {
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = UIImage(named: "bookimg")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(itemimage)
        itemimage.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        itemimage.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        itemimage.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}
