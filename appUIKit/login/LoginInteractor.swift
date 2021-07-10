//
//  LoginInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
class LoginInteractor{
    let presenter = LoginPresenter()
   
    func Valid(email : String , password: String) -> Bool{
        DBHelper.db = DBHelper.openDB()
        return  DBHelper.validate(email: email, enteredpassword: password)
        
    }
    func getuserid(email : String) -> Int{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getuserid(email: email)
    }
}
