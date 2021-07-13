//
//  Status.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import Foundation
class Status{
    var item_name : String
    var donar_id : Int
    var name :String
    
    var status : String
   
    init(item_name:String = "",donar_id:Int = 0,name:String = "",status:String = "")
    {
        self.item_name = item_name
        self.donar_id = donar_id
        self.name = name
        
        self.status = status
    }
}
