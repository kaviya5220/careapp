//
//  SignupInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
class SignupInteractor{
    func insertUser(user: User){
        DBHelper.db = DBHelper.openDB()
        DBHelper.insertuser(user: user)
    }
}
