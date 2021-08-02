//
//  AddItemInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 28/06/21.
//

import Foundation

class AddItemInteractor{
    func addItem(item : Item)->Int{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.insertItem(itemarg: item)
    }
    func addBook(itemid:Int,book:Books){
        DBHelper.db = DBHelper.openDB()
        return DBHelper.insertBook(item_id: itemid, book: book)
    }
    func addFood(itemid:Int,food:Food){
        DBHelper.db = DBHelper.openDB()
        return DBHelper.insertFood(item_id: itemid, food: food)
    }
}

