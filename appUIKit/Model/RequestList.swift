//
//  RequestList.swift
//  appUIKit
//
//  Created by sysadmin on 05/07/21.
//

import Foundation

class RequestList{
    var user_name: String
    var item_address: String
    var receiver_id : Int
    var item_id: Int
    var item_name : String
    
    init(user_name:String = "", item_address:String = "", receiver_id:Int = 0, item_id:Int = 0, item_name:String = "") {
        self.user_name = user_name
        self.item_address = item_address
        self.receiver_id = receiver_id
        self.item_id = item_id
        self.item_name = item_name
    }
    
}

