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
    func insertInKeychain(credentials : Credentials) throws {
      //  let  account = credentials.username
         let password = credentials.password.data(using: String.Encoding.utf8)!
         let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword as String,
                                     kSecAttrAccount as String: credentials.email,
                                     kSecValueData as String: password]
         print("KEY2")
         
        
         SecItemDelete(query as CFDictionary)
         let status : OSStatus = SecItemAdd(query as CFDictionary, nil)
         guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
}
