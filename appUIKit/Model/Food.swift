//
//  Food.swift
//  appUIKit
//
//  Created by sysadmin on 02/08/21.
//

import Foundation
class Food{
    
    var accompaniments : String
    var cusine : String
    var vegnonveg :String
    var quantity : Int
    var others:String
   
    init(accompaniments:String = "",cusine:String = "",vegnonveg:String = "",quantity:Int = 0,others:String = "")
    {
        self.accompaniments = accompaniments
        self.cusine = cusine
        self.vegnonveg = vegnonveg
        self.quantity = quantity
        self.others = others
    }
}
