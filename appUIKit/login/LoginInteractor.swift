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
//        DBHelper.db = DBHelper.openDB()
//        return  DBHelper.validate(email: email, enteredpassword: password)
        let getquery = [
                    kSecClass as String       : kSecClassGenericPassword,
                    kSecAttrAccount as String : email,
                    kSecReturnData as String  : kCFBooleanTrue,
            kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

        var dataTypeRef : AnyObject? = nil

        let status1 : OSStatus = SecItemCopyMatching(getquery as CFDictionary , &dataTypeRef)

                if status1 == noErr {
                    let returned_string : String = NSString(data: dataTypeRef as! Data, encoding: String.Encoding.utf8.rawValue)! as String
                     print("SIGNUP\(returned_string)")
                    if(password == returned_string){
                        return true}
                    else{
                        return false}
                } else {
                     print("Error")
                    return false
                }
        }
        
    func getuserid(email : String) -> Int{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.getuserid(email: email)
    }
}
