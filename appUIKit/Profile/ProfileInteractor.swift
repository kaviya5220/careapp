//
//  P.swift
//  appUIKit
//
//  Created by sysadmin on 03/07/21.
//

import Foundation
class ProfileInteractor {
    func getdonardetails(ID: Int) -> User{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getdonardetails(ID: ID)
    }
}
