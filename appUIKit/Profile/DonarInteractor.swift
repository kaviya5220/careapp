//
//  DonarInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import Foundation
class DonarInteractor{
    func getdonarProfile(ID: Int) -> [String]{
       // DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonarprofile(ID: ID)
    }
}
