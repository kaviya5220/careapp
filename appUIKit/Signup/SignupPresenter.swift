//
//  SignupPresenter.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
protocol SignUpPresenterDelegate : AnyObject {
    func showEmailError(errorMessage: String?)
    func showMobileError(errorMessage: String?)
    func removeEmailError()
    func removeMobileNumberError()
    func showAccountExists()
}
class SignupPresenter {
    weak var delegate: SignUpPresenterDelegate?

    func validateEmailId(emailId: String?) -> Bool{
        guard let emailId = emailId, emailId.count >= 5 else {
            delegate?.showEmailError(errorMessage: "Email-id is incorrect")
            return false
        }
        delegate?.removeEmailError()
        return true
    }
    
    func validateMobile(mobile: String?) -> Bool{
        guard let mobile = mobile, mobile.count >= 10 else {
            delegate?.showMobileError(errorMessage: "Mobile number is incorrect")
            return false
        }
        delegate?.removeMobileNumberError()
        return true
    }
    func accountExists(email:String) -> Bool
    {
            let getquery = [
                        kSecClass as String       : kSecClassGenericPassword,
                        kSecAttrAccount as String : email,
                        kSecReturnData as String  : kCFBooleanTrue,
                kSecMatchLimit as String  : kSecMatchLimitOne ] as [String : Any]

            var dataTypeRef : AnyObject? = nil

            let status1 : OSStatus = SecItemCopyMatching(getquery as CFDictionary , &dataTypeRef)

                    if status1 == noErr {
                        delegate?.showAccountExists()
                        return true
                        
                    }
                    else{
                        return false
                    }
    }
}
