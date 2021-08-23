//
//  DonorImageTableViewCell.swift
//  appUIKit
//
//  Created by Kaviya M on 21/08/21.
//

import UIKit

class DonorImageTableViewCell: UITableViewCell {
    let mySegmentedControl = UISegmentedControl (items: ["Books","Food","Cloth"])
    let itemimage:UIImageView = {
        let img = UIImageView()
        img.contentMode = .top
        img.image = UIImage(named: "default_product")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.layer.cornerRadius = 25
        img.clipsToBounds = true
        return img
    }()
    func createSegmentedControl(){
        mySegmentedControl.selectedSegmentIndex = 0
        mySegmentedControl.translatesAutoresizingMaskIntoConstraints = false
                //Change text color of UISegmentedControl
                mySegmentedControl.tintColor = UIColor.blue
                
                //Change UISegmentedControl background colour
                mySegmentedControl.backgroundColor = UIColor.white
                
                // Add function to handle Value Changed events
              
               
            }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createSegmentedControl()
        self.contentView.addSubview(itemimage)
        itemimage.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        self.contentView.addSubview(mySegmentedControl)
        mySegmentedControl.topAnchor.constraint(equalTo: itemimage.bottomAnchor,constant: 8).isActive = true
        mySegmentedControl.centerXAnchor.constraint(equalTo:self.contentView.centerXAnchor).isActive = true
        
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

