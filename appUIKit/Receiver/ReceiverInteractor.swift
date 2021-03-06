//
//  ReceiverInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 23/06/21.
//

import Foundation

class ReceiverInteractor{
 //   DBHelper.db = DBHelper.openDB()
    func getitemdetails()->[Item]{
        return DBHelper.getitems()
    }
    func getItemImages()->[Item_Image]{
      //  DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsImageName()
    }
    func getitemByID(ID : Int)->[String]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsbyID(ID: ID)
        
    }
    func getdonardetails(ID: Int) -> User{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonardetails(ID: ID)
    }
    func updateVisitedCount(ID: Int){
     //   DBHelper.db = DBHelper.openDB()
        DBHelper.update(itemid: ID)
    }
    func insertdonation(donation : Donationstatus){
       // DBHelper.db = DBHelper.openDB()
        DBHelper.insertdonationstatus(donararg: donation)
    }
    func getdonationstatus(Receiver_ID: Int, Item_ID : Int) -> String{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonationstatus(Receiver_ID: Receiver_ID, Item_ID: Item_ID)
    }
    func isLoggedIn() -> Bool{
        if UserDefaults.standard.string(forKey: "userid") != nil {
            return true
        }
        return false
    }
    func getBookDetails(itemid : Int) -> [String]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getbookDetails(itemid: itemid)
    }
    func getFoodDetails(itemid : Int) -> [String]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getFoodDetails(itemid: itemid)
    }
    func getClothDetails(itemid : Int) -> [String]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getClothDetails(itemid: itemid)
    }
    func getFood() -> [Food]{
      //  DBHelper.db = DBHelper.openDB()
        return DBHelper.getFoodItems()
    }
    func getBooks() -> [Books]{
        //DBHelper.db = DBHelper.openDB()
        return DBHelper.getBookItems()
    }
    func getCloth() -> [Cloth]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getClothItems()
    }
}
