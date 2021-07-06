//
//  RequestListInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 05/07/21.
//

import Foundation
class RequestListInteractor{
    func fetchRequestList(donarID: Int) -> [RequestList]{
        DBHelper.db = DBHelper.openDB()
        return DBHelper.fetchRequestList(Donar_ID: donarID)
    }
}
