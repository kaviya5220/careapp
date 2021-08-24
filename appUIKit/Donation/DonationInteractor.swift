//
//  DonationInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 02/07/21.
//

import Foundation
class DonationInteractor{
    func getitemdetailbydonarid(userid : Int)->[Item]{
     //   DBHelper.db = DBHelper.openDB()
        return DBHelper.getitemsbydonarID(Donar_ID: userid)
    }

}

