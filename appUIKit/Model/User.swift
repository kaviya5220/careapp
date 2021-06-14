//
//  User.swift
//  appUIKit
//
//  Created by sysadmin on 10/06/21.
//

import Foundation
class User{
    var user_name: String
    var user_phone: String
    var user_address: String
    var user_email: String
    var user_password: String
    
    init(user_name:String, user_phone:String, user_address:String, user_email:String, user_password:String) {
        self.user_name = user_name
        self.user_phone = user_phone
        self.user_address = user_address
        self.user_email = user_email
        self.user_password = user_password
    }
    
}
