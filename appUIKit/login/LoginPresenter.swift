//
//  LoginPresenter.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
protocol LoginPresenterDelegate : AnyObject {
    func showAlert()
    func showSignupSuccessAlert()
}
class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
    func showAlert(){
        print("Show alert")
        delegate?.showAlert()
    }
    func showSignupSuccessAlert(){
        delegate?.showSignupSuccessAlert()
    }
    
}

