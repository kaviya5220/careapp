//
//  Books.swift
//  appUIKit
//
//  Created by sysadmin on 31/07/21.
//

import Foundation
class Books{
    var item_id:Int
    var author : String
    var publisher : String
    var year_of_publish :String
    var quantity : Int
    var others:String
   
    init(author:String = "",publisher:String = "",year_of_publish:String = "",quantity:Int = 0,others:String = "",item_id:Int = 0)
    {
        self.author = author
        self.publisher = publisher
        self.year_of_publish = year_of_publish
        self.quantity = quantity
        self.others = others
        self.item_id = item_id
    }
}
