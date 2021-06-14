//
//  LoginPresenter.swift
//  appUIKit
//
//  Created by sysadmin on 12/06/21.
//

import Foundation
protocol LoginPresenterDelegate : AnyObject {
    func showAlert()
}
class LoginPresenter {
    weak var delegate: LoginPresenterDelegate?
//     init(view:PresenterView){
//            self.presenterView = view
//        }
    func showAlert(){
        print("Show alert")
        delegate?.showAlert()
    }
    
}

