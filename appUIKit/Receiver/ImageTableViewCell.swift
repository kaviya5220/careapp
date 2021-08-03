//
//  ImageTableViewCell.swift
//  appUIKit
//
//  Created by sysadmin on 03/08/21.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .top
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(itemimage)
        itemimage.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
