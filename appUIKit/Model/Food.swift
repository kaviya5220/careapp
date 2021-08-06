//
//  Food.swift
//  appUIKit
//
//  Created by sysadmin on 02/08/21.
//

import Foundation
class Food{
    var item_id : Int
    var expiry_date : String
    var cusine : String
    var vegnonveg :String
    var quantity : Int
    var others:String
   
    init(expiry_date:String = "",cusine:String = "",vegnonveg:String = "",quantity:Int = 0,others:String = "",item_id : Int = 0)
    {
        self.expiry_date = expiry_date
        self.cusine = cusine
        self.vegnonveg = vegnonveg
        self.quantity = quantity
        self.others = others
        self.item_id = item_id
    }
}
