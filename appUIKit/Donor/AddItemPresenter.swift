//
//  AddItemPresenter.swift
//  appUIKit
//
//  Created by sysadmin on 28/06/21.
//

import Foundation
protocol AddItemPresenterDelegate : AnyObject {
    func showSuccessAlert()
}
class AddItemPresenter {
    weak var delegate: AddItemPresenterDelegate?
    func showSuccessAlert(){
        delegate?.showSuccessAlert()
    }
    
}
