//
//  ReceiverInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 23/06/21.
//

import Foundation

class ReceiverInteractor{
    func getitemdetails()->[Item]{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getitems()
    }
    func getitemByID(ID : Int)->Item{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsbyID(ID: ID)
        
    }
    func getdonardetails(ID: Int) -> User{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonardetails(ID: ID)
    }
    func updateVisitedCount(ID: Int){
        DBHelper.db = DBHelper.openDB()
        DBHelper.update(itemid: ID)
    }
}
