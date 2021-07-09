//
//  RequestList.swift
//  appUIKit
//
//  Created by sysadmin on 05/07/21.
//

import Foundation

class RequestList{
    var receiver_name: String
    var receiver_address: String
    var receiver_phone : String
    var receiver_email : String
    var receiver_id : Int
    var item_id: Int
    var item_name : String
    
    init(receiver_name:String = "",receiver_phone: String = "", receiver_email: String = "",
         receiver_address:String = "", receiver_id:Int = 0, item_id:Int = 0, item_name:String = "") {
        self.receiver_name = receiver_name
        self.receiver_phone = receiver_phone
        self.receiver_email = receiver_email
        self.receiver_address = receiver_address
        self.receiver_id = receiver_id
        self.item_id = item_id
        self.item_name = item_name
    }    
}

