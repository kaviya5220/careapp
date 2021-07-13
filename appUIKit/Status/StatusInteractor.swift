//
//  StatusInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 12/07/21.
//

import Foundation
class StatusInteractor{
    func fetchStatus(receiver_id : Int)->[Status]{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.fetchStatus(receiver_id: receiver_id)
    }
}
