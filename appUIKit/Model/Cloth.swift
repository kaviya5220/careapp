//
//  Cloth.swift
//  appUIKit
//
//  Created by sysadmin on 07/08/21.
//

import Foundation
class Cloth{
    var item_id : Int
    var size : String
    var clothCategory : String
    var gender : String
    var quantity : Int
    var others:String
   
    init(size:String = "",clothCategory:String = "",gender:String = "",quantity:Int = 0,others:String = "",item_id : Int = 0)
    {
        self.size = size
        self.clothCategory = clothCategory
        self.gender = gender
        self.quantity = quantity
        self.others = others
        self.item_id = item_id
    }
}
