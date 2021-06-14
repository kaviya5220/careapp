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
    
}
