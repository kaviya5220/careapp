//
//  Donationstatus.swift
//  appUIKit
//
//  Created by sysadmin on 02/07/21.
//

import Foundation
class Donationstatus {
    var item_id: Int
    var Donar_ID: Int
    var Receiver_ID: Int
    var status: String
    
    init(item_id: Int = 0,Donar_ID : Int = 0,Receiver_ID : Int = 0,status :String = "") {
        self.item_id = item_id
        self.Donar_ID = Donar_ID
        self.Receiver_ID = Receiver_ID
        self.status = status
    }
}
