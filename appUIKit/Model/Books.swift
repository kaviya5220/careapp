//
//  Books.swift
//  appUIKit
//
//  Created by sysadmin on 31/07/21.
//

import Foundation
class Books{
    
    var author : String
    var publisher : String
    var year_of_publish :String
    var quantity : Int
    var others:String
   
    init(author:String = "",publisher:String = "",year_of_publish:String = "",quantity:Int = 0,others:String = "")
    {
        self.author = author
        self.publisher = publisher
        self.year_of_publish = year_of_publish
        self.quantity = quantity
        self.others = others
    }
}
