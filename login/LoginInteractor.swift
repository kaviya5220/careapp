//
//  LoginInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
class LoginInteractor{
   // weak var delegate: PresenterView?
    let presenter = LoginPresenter()
    var db = DBHelper()
    func Valid(email : String , password: String) -> Bool{
      return  db.validate(email: email, enteredpassword: password)
        
    }
}
