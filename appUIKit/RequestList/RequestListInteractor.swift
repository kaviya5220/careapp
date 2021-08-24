//
//  RequestListInteractor.swift
//  appUIKit
//
//  Created by sysadmin on 05/07/21.
//

import Foundation
class RequestListInteractor{
    func fetchRequestList(donarID: Int) -> [RequestList]{
        //DBHelper.db = DBHelper.openDB()
        return DBHelper.fetchRequestList(Donar_ID: donarID)
    }
    func updatestatus(receiverID: Int,item_id : Int) {
       // DBHelper.db = DBHelper.openDB()
        DBHelper.updatestatus(receiverid: receiverID,item_id: item_id)
    }
    func updateOtherRequests(receiverID: Int,item_id : Int) {
        //DBHelper.db = DBHelper.openDB()
        DBHelper.updateOtherRequests(receiverid : receiverID,item_id:item_id)
    }
}
