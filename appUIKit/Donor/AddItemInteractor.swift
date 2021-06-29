//
//  AddItemInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 28/06/21.
//

import Foundation

class AddItemInteractor{
    func addItem(item : Item)->Bool{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.insertItem(itemarg: item)
    }
}

