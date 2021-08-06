//
//  FoodDetails.swift
//  appUIKit
//
//  Created by sysadmin on 06/08/21.
//

import Foundation
class FoodDetails{
    var item_id: Int
    var item_name: String
    var item_image : String
    var category: String
    var address: String
    var Donar_ID: Int
    var visited_count : Int
    var date: String
    var food: Food
    
    init(item_id: Int = 0,item_name: String = "",item_image: String = "", category: String = "",address: String = "",Donar_ID : Int = 0,visited_count : Int = 0,date :String = "",food : Food = Food())
    
    {
        self.item_id = item_id
        self.item_name = item_name
        self.item_image = item_image
        self.category = category
        self.address = address
        self.Donar_ID = Donar_ID
        self.visited_count = visited_count
        self.date = date
        self.food = food
    }
}
