//
//  SignupInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
class SignupInteractor{
    //var db = DBHelper()
    func insertUser(user: User){
        DBHelper.insertuser(user: user)
    }
}
