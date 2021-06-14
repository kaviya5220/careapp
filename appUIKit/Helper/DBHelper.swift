//
//  dbHelper.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import Foundation
import SQLite3
class DBHelper{
    var db : OpaquePointer?
    var flag : Bool = false
    var path : String = "AppDataBase.sqlite"
    init() {
        self.db = createDB()
        self.createTable()
        self.createItemTable()
    }
    
    func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("There is error in creating DB")
            return nil
        }else {
            print("Database has been created with path \(filePath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS UserDetails(
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Name CHAR(255),Phone CHAR(255),Address CHAR(255),Email CHAR(255),Password CHAR(255));
        """
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("\nUserDetails table created.")
        } else {
          print("\nUserDetails table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    }
    func insertuser(user : User){
    let insertStatementString = "INSERT INTO UserDetails (Name,Phone,Address,Email,Password) VALUES (?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let personname: NSString = user.user_name as NSString
        let personphone: NSString = user.user_phone as NSString
        let personaddress: NSString = user.user_address as NSString
        let personemail: NSString = user.user_email as NSString
        let personpassword : NSString = user.user_password as NSString
        
        sqlite3_bind_text(insertStatement, 1, personname.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, personphone.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, personaddress.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, personemail.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 5, personpassword.utf8String, -1, nil)
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
        } else {
          print("\nCould not insert row.")
        }
      } else {
        print("\nINSERT statement is not prepared.")
      }
      sqlite3_finalize(insertStatement)
    }
    func validate(email : String , enteredpassword : String) -> Bool {
        let queryStatementString = "SELECT Password FROM UserDetails WHERE Email = ?;"
        var valid : Bool = false
        var queryStatement: OpaquePointer?
        var password : String = ""
        let email: NSString = email as NSString
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil)
            if sqlite3_step(queryStatement) == SQLITE_ROW {
              guard let queryResultCol1 = sqlite3_column_text(queryStatement, 0) else {
                print("Query result is nil")
                return false
              }
              password = String(cString: queryResultCol1)
              print("\nQuery Result:")
              print(" \(password) ")
                if(password.elementsEqual(enteredpassword)){
                    valid = true
                }
          } else {
              print("\nQuery returned no results.")
          }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        print("DB_Helper \(valid) \(password) \(enteredpassword)")
        return valid
        }
    func createItemTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS ItemDetails(
        Item_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Item_Name CHAR(255),Item_Description CHAR(255),Item_Quantity CHAR(255),Address CHAR(255),Donar_ID INTEGER);
        """
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("ItemDetails table created.")
        } else {
          print("ItemDetails table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    }
    func insertItem(itemarg : Item) -> Bool{
//        print(Donarid)
//        print(itemname)
//        print(itemquantity)
//        print(itemdescription)
//        print(itemimage)
    let insertStatementString = "INSERT INTO ItemDetails (Item_Name,Item_Description,Item_Quantity,Address,Donar_ID) VALUES (?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let name: NSString = itemarg.item_name as NSString
        let description: NSString = itemarg.item_description as NSString
        let quantity: NSString = itemarg.item_quantity as NSString
        let address: NSString = itemarg.address as NSString
        let donarid = itemarg.Donar_ID
        sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, description.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, quantity.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, address.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 5, Int32(donarid))
        
        print(insertStatement!)
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
            //sqlite3_finalize(insertStatement)
            flag = true
        } else {
            let errmsge = String(cString: sqlite3_errmsg(db)!)
            print("failure\(errmsge)")
          print("\nCould not insert row.")
        }
      } else {
        print("\nINSERT statement is not prepared.")
      }
      sqlite3_finalize(insertStatement)
        if sqlite3_close(db) == SQLITE_OK {
                        print("closing database")
                    }
        return flag
    }
    func getuserid(email : String ) -> Int {
        print(email)
        let queryStatementString = "SELECT ID FROM UserDetails WHERE Email = ?;"
        var userid : Int = 0
        var queryStatement: OpaquePointer?
        let email: NSString = email as NSString
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil)
            if sqlite3_step(queryStatement) == SQLITE_ROW {
             let queryResultCol1 = sqlite3_column_int(queryStatement, 0)
                userid = Int(queryResultCol1)
              print("\nQuery Result:")
              print(" \(userid) ")
                //return userid
          } else {
              print("\nQuery returned no results.")
          }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return userid
        }
    func getitems() -> [Item] {
        let queryStatementString = "SELECT * FROM ItemDetails;"
        var itemlist : [Item] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_text(queryStatement, 1, email.utf8String, -1, nil)
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
                
                let item : Item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_description: String(cString: queryResultCol2!), item_quantity: String(cString: queryResultCol3!), address: String(cString: queryResultCol4!), Donar_ID: Int(queryResultCol5))
                itemlist.append(item)
              
                //return userid
            }
            print("\nQuery Result:")
              print(itemlist)
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return itemlist
        }
}
