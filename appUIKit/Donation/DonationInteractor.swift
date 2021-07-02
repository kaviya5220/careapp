//
//  DonationInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 02/07/21.
//

import Foundation
class DonationInteractor{
    func getitemdetailbydonarid(userid : Int)->[Item]{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsbydonarID(Donar_ID: userid)
    }
    func getitemByID(ID : Int)->Item{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsbyID(ID: ID)
        
    }
    func getdonardetails(ID: Int) -> User{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonardetails(ID: ID)
    }
}

