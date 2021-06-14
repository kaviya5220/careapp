//
//  Item.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import Foundation
class Item {
    var item_id: Int
    var item_name: String
    var item_description: String
    var item_quantity: String
    var address: String
    var Donar_ID: Int
    
    init(item_id: Int,item_name: String,item_description: String,item_quantity: String,address: String,Donar_ID : Int) {
        self.item_id = item_id
        self.item_name = item_name
        self.item_description = item_description
        self.item_quantity = item_quantity
        self.address = address
        self.Donar_ID = Donar_ID
    }
}
