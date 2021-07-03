//
//  dbHelper.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import Foundation
import SQLite3
import CryptoSwift
class DBHelper{
    static var db : OpaquePointer?
    static var flag : Bool = false
    static var path : String = "AppDataBase.sqlite"
    init() {
        DBHelper.db =  DBHelper.openDB()
        DBHelper.createTable()
        DBHelper.createItemTable()
        DBHelper.createStatusTable()
    }
    static func aesDecrypt(endata : String) throws -> String {
            let key: String  = "secret0key000000"
            let iv:  String  = "0000000000000000"
           // let data : [UInt8] = Array(endata.utf8)
            guard let data = Data(base64Encoded: endata) else { return "" }
            let decrypted = try AES(key: key, iv: iv, padding: .pkcs7).decrypt([UInt8] (data))
            return String(bytes: decrypted, encoding: .utf8) ?? ""
        }
    static func openDB() -> OpaquePointer? {
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
    
    static func createTable() {
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
    static func insertuser(user : User){
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
    static func validate(email : String , enteredpassword : String) -> Bool {
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
                let decryptdata = try! aesDecrypt(endata : password)
                print(decryptdata)
                if(decryptdata.elementsEqual(enteredpassword)){
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
    static func createItemTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS ItemDetails(
        Item_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Item_Name CHAR(255),Item_Description CHAR(255),Item_Quantity CHAR(255),Address CHAR(255),Donar_ID INTEGER,
        Visited_count INTEGER DEFAULT 0, Date_posted CHAR(255), Item_ImageName CHAR(255));
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
    static func insertItem(itemarg : Item) -> Int
    {
    let insertStatementString = "INSERT INTO ItemDetails (Item_Name,Item_Description,Item_Quantity,Address,Donar_ID,Date_posted,Item_ImageName) VALUES (?, ?, ?, ?, ?, ?,?);"
      var insertStatement: OpaquePointer?
    var itemid:Int = 0;
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let name: NSString = itemarg.item_name as NSString
        let description: NSString = itemarg.item_description as NSString
        let quantity: NSString = itemarg.item_quantity as NSString
        let address: NSString = itemarg.address as NSString
        let donarid = itemarg.Donar_ID
        let date: NSString = itemarg.date as NSString
        let item_image_name: NSString = itemarg.item_image as NSString
        sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, description.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, quantity.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, address.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 5, Int32(donarid))
        sqlite3_bind_text(insertStatement, 6, date.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 7, item_image_name.utf8String, -1, nil)
        
        
        print(insertStatement!)
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
            itemid = Int(sqlite3_last_insert_rowid(db))
            print("Item id\(itemid)")
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
        return itemid
    }
    static func getuserid(email : String ) -> Int {
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
              //print("\nQuery Result:")
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
    static func getitems() -> [Item] {
        let queryStatementString = "SELECT * FROM ItemDetails ;"
        var itemlist : [Item] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_int(queryStatement, 1, Int32(donarid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
            let queryResultCol6 = sqlite3_column_int(queryStatement, 6)
            let queryResultCol7 = sqlite3_column_text(queryStatement, 7)
            let queryResultCol8 = sqlite3_column_text(queryStatement, 8)
                let item : Item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_description: String(cString: queryResultCol2!), item_image: String(cString:queryResultCol8!), item_quantity: String(cString: queryResultCol3!), address: String(cString: queryResultCol4!), Donar_ID: Int(queryResultCol5), visited_count: Int(queryResultCol6), date: String(cString:queryResultCol7!))
                itemlist.append(item)
              
                //return userid
            }
           // print("\nQuery Result:")
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
    static func getitemsbyID(ID : Int) -> Item {
        let queryStatementString = "SELECT * FROM ItemDetails  WHERE Item_ID = ?;"
        var item : Item = Item()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(ID))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
            let queryResultCol6 = sqlite3_column_int(queryStatement, 6)
            let queryResultCol7 = sqlite3_column_text(queryStatement, 7)
            let queryResultCol8 = sqlite3_column_text(queryStatement, 8)
                
                item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_description: String(cString: queryResultCol2!), item_image: String(cString:queryResultCol8!),item_quantity: String(cString: queryResultCol3!), address: String(cString: queryResultCol4!), Donar_ID: Int(queryResultCol5), visited_count: Int(queryResultCol6), date: String(cString:queryResultCol7!))
               
              
                //return userid
            }
            print("\nQuery Result:")
              print(item)
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return item
        }
    
    static func getdonardetails(ID : Int) -> User {
        let queryStatementString = "SELECT * FROM UserDetails  WHERE ID = ?;"
        var user : User = User()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(ID))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                
                user = User(user_name:String(cString: queryResultCol1!), user_phone: String(cString: queryResultCol2!), user_address: String(cString: queryResultCol3!), user_email: String(cString: queryResultCol4!), user_password: String(cString: queryResultCol5!))
               
              
                //return userid
            }
            print("\nQuery Result:")
              print(user)
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return user
        }
    static func update(itemid : Int) {
      var updateStatement: OpaquePointer?
        let updateStatementString = "UPDATE ItemDetails SET Visited_count = Visited_count+1 WHERE Item_ID = ?;"
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
            sqlite3_bind_int(updateStatement, 1, Int32(itemid))
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
        } else {
          print("\nCould not update row.")
        }
      } else {
        print("\nUPDATE statement is not prepared")
      }
      sqlite3_finalize(updateStatement)
    }
    static func getitemsbydonarID(Donar_ID : Int) -> [Item] {
        let queryStatementString = "SELECT * FROM ItemDetails  WHERE Donar_ID = ?;"
        var items : [Item] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(Donar_ID))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
            let queryResultCol6 = sqlite3_column_int(queryStatement, 6)
            let queryResultCol7 = sqlite3_column_text(queryStatement, 7)
                let queryResultCol8 = sqlite3_column_text(queryStatement, 8)
                
                let item: Item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_description: String(cString: queryResultCol2!), item_image: String(cString:queryResultCol8!), item_quantity: String(cString: queryResultCol3!), address: String(cString: queryResultCol4!), Donar_ID: Int(queryResultCol5), visited_count: Int(queryResultCol6), date: String(cString:queryResultCol7!))
                items.append(item)
               
              
                //return userid
            }
            print("\nQuery Result:")
              print(items)
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return items
        }
    static func createStatusTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS DonationStatus(
        Item_ID INTEGER ,Donar_ID INTEGER ,Receiver_ID INTEGER ,Status CHAR(255));
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
    static func insertdonationstatus(donararg : Donationstatus)
    {
    let insertStatementString = "INSERT INTO DonationStatus (Item_ID,Donar_ID,Receiver_ID,Status) VALUES (?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
    
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let itemid = donararg.item_id
        let donarid = donararg.Donar_ID
        let receiverid = donararg.Receiver_ID
        let status: NSString = donararg.status as NSString
        sqlite3_bind_int(insertStatement, 1, Int32(itemid))
        sqlite3_bind_int(insertStatement, 2, Int32(donarid))
        sqlite3_bind_int(insertStatement, 3, Int32(receiverid))
        sqlite3_bind_text(insertStatement, 4, status.utf8String, -1, nil)
        
        
        print(insertStatement!)
        if sqlite3_step(insertStatement) == SQLITE_DONE {
          print("\nSuccessfully inserted row.")
          
            
        
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
      
    }
    static func getdonationstatus(Receiver_ID : Int,Item_ID : Int) -> String {
        let queryStatementString = "SELECT Status FROM DonationStatus  WHERE Item_ID = ? AND Receiver_ID = ?;"
        var status : String = ""
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(Item_ID))
            sqlite3_bind_int(queryStatement, 2, Int32(Receiver_ID))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_text(queryStatement, 0)
             status = String(cString:queryResultCol0!)
            }
            print("\nQuery Result:")
              print(status)
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
        if sqlite3_close(db) == SQLITE_OK {
            print("closing database")
        }
        return status
        }
}
