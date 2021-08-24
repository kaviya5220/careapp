//
//  dbHelper.swift
//  appUIKit
//
//  Created by sysadmin on 09/06/21.
//

import Foundation
import SQLite3
class DBHelper{
    static var db : OpaquePointer?
    static var flag : Bool = false
    static var path : String = "AppDataBase.sqlite"
    init() {
        DBHelper.db =  DBHelper.openDB()
        DBHelper.createTable()
        DBHelper.createItemTable()
        DBHelper.createStatusTable()
        DBHelper.createBookTable()
        DBHelper.createFoodTable()
        DBHelper.createClothTable()
    }
    
    static func openDB() -> OpaquePointer? {
         let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db : OpaquePointer? = nil
        
        if sqlite3_open_v2(filePath.path, &db,SQLITE_OPEN_CREATE | SQLITE_OPEN_READWRITE | SQLITE_OPEN_FULLMUTEX, nil) != SQLITE_OK {
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
    static func insertBook(item_id:Int,book : Books){
    let insertStatementString = "INSERT INTO Books (Item_ID,Author,Publisher,year_of_publish,Quantity,Others) VALUES (?, ?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let item_id: Int = item_id
        let author: NSString = book.author as NSString
        let publisher: NSString = book.publisher as NSString
        let year_of_publish: NSString = book.year_of_publish as NSString
        let quantity : Int = book.quantity
        let others:NSString = book.others as NSString
        
        sqlite3_bind_int(insertStatement, 1, Int32(item_id))
        sqlite3_bind_text(insertStatement, 2, author.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, publisher.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, year_of_publish.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 5, Int32(quantity))
        sqlite3_bind_text(insertStatement, 6, others.utf8String, -1, nil)
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
    static func insertFood(item_id:Int,food : Food){
    let insertStatementString = "INSERT INTO Food (Item_ID,expiry_date,Cusine,VegNonVeg,Quantity,Others) VALUES (?, ?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let item_id: Int = item_id
        let expiry_date: NSString = food.expiry_date as NSString
        let cusine: NSString = food.cusine as NSString
        let vegnonveg: NSString = food.vegnonveg as NSString
        let quantity : Int = food.quantity
        let others:NSString = food.others as NSString
        
        sqlite3_bind_int(insertStatement, 1, Int32(item_id))
        sqlite3_bind_text(insertStatement, 2, expiry_date.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, cusine.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, vegnonveg.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 5, Int32(quantity))
        sqlite3_bind_text(insertStatement, 6, others.utf8String, -1, nil)
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
    
    static func insertCloth(item_id:Int,cloth : Cloth){
    let insertStatementString = "INSERT INTO Cloth (Item_ID,Size,clothCategory,Gender,Quantity,Others) VALUES (?, ?, ?, ?, ?, ?);"
      var insertStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let item_id: Int = item_id
        let Size: NSString = cloth.size as NSString
        let clothCategory: NSString = cloth.clothCategory as NSString
        let Gender: NSString = cloth.gender as NSString
        let quantity : Int = cloth.quantity
        let others:NSString = cloth.others as NSString
        
        sqlite3_bind_int(insertStatement, 1, Int32(item_id))
        sqlite3_bind_text(insertStatement, 2, Size.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, clothCategory.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 4, Gender.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 5, Int32(quantity))
        sqlite3_bind_text(insertStatement, 6, others.utf8String, -1, nil)
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
               
                if(password == (enteredpassword)){
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
        Item_Name CHAR(255),Category CHAR(255),Address CHAR(255),Donar_ID INTEGER,
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
    static func createBookTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Books(
        Item_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Author CHAR(255),Publisher CHAR(255),year_of_publish CHAR(255),Quantity INTEGER,Others CHAR(255));
        """
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("Books table created.")
        } else {
          print("Books table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    }
    static func createFoodTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Food(
        Item_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        expiry_date CHAR(255),Cusine CHAR(255),VegNonVeg CHAR(255),Quantity INTEGER,Others CHAR(255));
        """
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("Food table created.")
        } else {
          print("Food table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    }
    static func createClothTable() {
        let createTableString = """
        CREATE TABLE IF NOT EXISTS Cloth(
        Item_ID INTEGER PRIMARY KEY AUTOINCREMENT,
        Size CHAR(255),clothCategory CHAR(255),Gender CHAR(255),Quantity INTEGER,Others CHAR(255));
        """
      var createTableStatement: OpaquePointer?
      if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) ==
          SQLITE_OK {
        if sqlite3_step(createTableStatement) == SQLITE_DONE {
          print("Cloth table created.")
        } else {
          print("Cloth table is not created.")
        }
      } else {
        print("\nCREATE TABLE statement is not prepared.")
      }
      sqlite3_finalize(createTableStatement)
    }
    static func insertItem(itemarg : Item) -> Int
    {
    let insertStatementString = "INSERT INTO ItemDetails (Item_Name,Category,Address,Donar_ID,Date_posted,Item_ImageName) VALUES (?, ?, ?, ?, ?,?);"
      var insertStatement: OpaquePointer?
    var itemid:Int = 0;
      if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) ==
          SQLITE_OK {
        let name: NSString = itemarg.item_name as NSString
        let category: NSString = itemarg.category as NSString
        let address: NSString = itemarg.address as NSString
        let donarid = itemarg.Donar_ID
        let date: NSString = itemarg.date as NSString
        let item_image_name: NSString = itemarg.item_image as NSString
        sqlite3_bind_text(insertStatement, 1, name.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 2, category.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 3, address.utf8String, -1, nil)
        sqlite3_bind_int(insertStatement, 4, Int32(donarid))
        sqlite3_bind_text(insertStatement, 5, date.utf8String, -1, nil)
        sqlite3_bind_text(insertStatement, 6, item_image_name.utf8String, -1, nil)
        
        
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
//        if sqlite3_close(db) == SQLITE_OK {
//                        print("closing database")
//                    }
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
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return userid
        }
    static func getbookDetails(itemid : Int ) -> [String] {
        let queryStatementString = "SELECT * FROM Books WHERE Item_ID = ?;"
        var book = [String]()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(itemid))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
                let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                book.append(String(cString: queryResultCol1!))
                book.append(String(cString: queryResultCol2!))
                book.append(String(cString: queryResultCol3!))
                book.append(String(Int((queryResultCol4))))
                book.append(String(cString: queryResultCol5!))
                
                            
               
          } else {
              print("\nQuery returned no results.")
          }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return book
        }
    static func getFoodDetails(itemid : Int ) -> [String] {
        let queryStatementString = "SELECT * FROM Food WHERE Item_ID = ?;"
        var food = [String]()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(itemid))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
                let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                food.append(String(cString: queryResultCol1!))
                food.append(String(cString: queryResultCol2!))
                food.append(String(cString: queryResultCol3!))
                food.append(String(Int((queryResultCol4))))
                food.append(String(cString: queryResultCol5!))
                
                            
               
          } else {
              print("\nQuery returned no results.")
          }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return food
        }
    static func getClothDetails(itemid : Int ) -> [String] {
        let queryStatementString = "SELECT * FROM Cloth WHERE Item_ID = ?;"
        var cloth = [String]()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(itemid))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
                let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                cloth.append(String(cString: queryResultCol1!))
                cloth.append(String(cString: queryResultCol2!))
                cloth.append(String(cString: queryResultCol3!))
                cloth.append(String(Int((queryResultCol4))))
                cloth.append(String(cString: queryResultCol5!))
                
                            
               
          } else {
              print("\nQuery returned no results.")
          }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return cloth
        }
    static func getitems() ->  [Item] {
        
        let queryStatementString = "SELECT Item_ID,Item_Name,Category,Address,Donar_ID,Visited_count,Date_posted FROM ItemDetails WHERE Item_ID IN(SELECT Item_ID FROM DonationStatus WHERE Status = 'pending') OR Item_ID NOT IN(SELECT Item_ID FROM DonationStatus) ORDER BY Item_Name;"
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
             let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
            let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
            let queryResultCol6 = sqlite3_column_text(queryStatement, 6)
                let item : Item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_image: "", category: String(cString: queryResultCol2!), address: String(cString: queryResultCol3!), Donar_ID: Int(queryResultCol4), visited_count: Int(queryResultCol5), date: String(cString:queryResultCol6!))
                itemlist.append(item)
              
                //return userid
            }
           // print("\nQuery Result:")
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
//          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return itemlist
        }
    static func getitemsImageName() ->  [Item_Image] {
        var item_image_list : [Item_Image] = []
        let queryStatementString = "SELECT Item_ID,Item_ImageName FROM ItemDetails WHERE Item_ID IN(SELECT Item_ID FROM DonationStatus WHERE Status = 'pending') OR Item_ID NOT IN(SELECT Item_ID FROM DonationStatus) ORDER BY Item_Name;"
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_int(queryStatement, 1, Int32(donarid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                item_image_list.append(Item_Image(item_id: Int(queryResultCol0), item_image: String(cString: queryResultCol1!)))
              
                //return userid
            }
           // print("\nQuery Result:")
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
//          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return item_image_list
        }
    static func getitemsbyID(ID : Int) -> [String] {
        let queryStatementString = "SELECT Item_Name,Category,Address,Donar_ID,Item_ImageName FROM ItemDetails  WHERE Item_ID = ?;"
        var item = [String]()
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(ID))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
    
             
             let queryResultCol1 = sqlite3_column_text(queryStatement, 0)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 2)
            let queryResultCol4 = sqlite3_column_text(queryStatement, 3)
                let queryResultCol5 = sqlite3_column_text(queryStatement, 4)
                item.append(String(cString: queryResultCol1!))
                item.append(String(cString: queryResultCol2!))
                item.append(String(cString: queryResultCol3!))
                item.append(String(cString: queryResultCol4!))
                item.append(String(cString: queryResultCol5!))
               
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
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
    
            // let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_text(queryStatement, 4)
             let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                
                user = User(user_name:String(cString: queryResultCol1!), user_phone: String(cString: queryResultCol2!), user_address: String(cString: queryResultCol3!), user_email: String(cString: queryResultCol4!), user_password: String(cString: queryResultCol5!))
               
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
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
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
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
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
               let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
               let queryResultCol6 = sqlite3_column_text(queryStatement, 6)
               let queryResultCol7 = sqlite3_column_text(queryStatement, 7)
                   
                let item:Item = Item(item_id: Int(queryResultCol0), item_name: String(cString: queryResultCol1!), item_image: String(cString:queryResultCol7!),category: String(cString: queryResultCol2!), address: String(cString: queryResultCol3!), Donar_ID: Int(queryResultCol4), visited_count: Int(queryResultCol5), date: String(cString:queryResultCol6!))
                items.append(item)
               
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
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
          print("Donation Table table created.")
        } else {
          print("Donation Table table is not created.")
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
//        if sqlite3_close(db) == SQLITE_OK {
//                        print("closing database")
//                    }
      
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
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return status
        }
    static func fetchRequestList(Donar_ID : Int) -> [RequestList] {
        let queryStatementString = "SELECT Name,Phone,Email,UserDetails.Address,Receiver_ID,ItemDetails.Item_ID,Item_Name  from UserDetails,DonationStatus,ItemDetails where ItemDetails.Item_ID = DonationStatus.Item_ID and ItemDetails.Donar_ID = DonationStatus.Donar_ID  AND DonationStatus.Donar_ID = ? AND UserDetails.ID = DonationStatus.Receiver_ID AND Status = 'pending' ORDER BY ItemDetails.Item_Name"
        var requestlist : [RequestList] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(Donar_ID))
           
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
                let queryResultCol0 = sqlite3_column_text(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
                let queryResultCol5 = sqlite3_column_int(queryStatement, 5)
                let queryResultCol6 = sqlite3_column_text(queryStatement, 6)
                let request: RequestList = RequestList(receiver_name:String(cString: queryResultCol0!) , receiver_phone: String(cString: queryResultCol1!), receiver_email: String(cString: queryResultCol2!), receiver_address: String(cString: queryResultCol3!), receiver_id: Int(queryResultCol4), item_id: Int(queryResultCol5), item_name: String(cString: queryResultCol6!))
                requestlist.append(request)
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return requestlist
        }
    static func fetchStatus(receiver_id : Int) -> [Status]{
        print("Rec\(receiver_id)")
        let queryStatementString = "SELECT Item_Name,ID,Name,Status from ItemDetails,UserDetails,DonationStatus where Receiver_ID = ? and ItemDetails.Donar_ID = UserDetails.ID AND ItemDetails.Item_ID = DonationStatus.Item_ID"
        var statuslist : [Status] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(receiver_id))
           
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
                let queryResultCol0 = sqlite3_column_text(queryStatement, 0)
                let queryResultCol1 = sqlite3_column_int(queryStatement, 1)
                let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
                let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                
                let status: Status = Status(item_name: String(cString: queryResultCol0!) , donar_id: Int(queryResultCol1), name: String(cString: queryResultCol2!) , status: String(cString: queryResultCol3!) )
                   
                statuslist.append(status)
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return statuslist
        }
    static func getdonarprofile(ID : Int) -> [String] {
        let queryStatementString = "SELECT Name,Phone,Address,Email FROM UserDetails  WHERE ID = ?;"
        var user : [String] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
            sqlite3_bind_int(queryStatement, 1, Int32(ID))
            if sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_text(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
                
                user.append(String(cString: queryResultCol0!))
                user.append(String(cString: queryResultCol1!))
                user.append(String(cString: queryResultCol2!))
                user.append(String(cString: queryResultCol3!))
               
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return user
        }
    static func updatestatus(receiverid : Int,item_id:Int) {
      var updateStatement: OpaquePointer?
        let updateStatementString = "UPDATE DonationStatus SET Status = 'accepted' WHERE Receiver_ID = ? and Item_ID=?;"
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
          SQLITE_OK {
            sqlite3_bind_int(updateStatement, 1, Int32(receiverid))
            sqlite3_bind_int(updateStatement, 2, Int32(item_id))
        if sqlite3_step(updateStatement) == SQLITE_DONE {
          print("\nSuccessfully updated row.")
        } else {
          print("\nCould not update row.")
        }
      } else {
        print("\nUPDATE statement is not prepared")
      }
        sqlite3_finalize(updateStatement);
    }
    static func updateOtherRequests(receiverid : Int,item_id:Int) {
        var updateStatement: OpaquePointer?
          let updateStatementString = "UPDATE DonationStatus SET Status = 'rejected' WHERE Receiver_ID != ? and Item_ID=?;"
          if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
            SQLITE_OK {
              sqlite3_bind_int(updateStatement, 1, Int32(receiverid))
              sqlite3_bind_int(updateStatement, 2, Int32(item_id))
          if sqlite3_step(updateStatement) == SQLITE_DONE {
            print("\nSuccessfully updated row.")
          } else {
            print("\nCould not update row.")
          }
        } else {
          print("\nUPDATE statement is not prepared")
        }
          sqlite3_finalize(updateStatement);
      }
    static func getFoodItems() ->  [Food] {
        
        let queryStatementString = "SELECT Food.Item_ID,expiry_date,Cusine,VegNonVeg,Quantity,Others FROM ItemDetails,Food  WHERE Food.Item_ID IN(SELECT Item_ID FROM DonationStatus WHERE Status = 'pending') OR Food.Item_ID NOT IN(SELECT Item_ID FROM DonationStatus)  and Food.Item_ID = ItemDetails.Item_ID ORDER BY ItemDetails.Item_Name;"
        var foodList : [Food] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_int(queryStatement, 1, Int32(donarid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
            let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                let food : Food = Food(expiry_date: String(cString: queryResultCol1!), cusine: String(cString: queryResultCol2!), vegnonveg: String(cString: queryResultCol3!), quantity: Int(queryResultCol4), others: String(cString: queryResultCol5!), item_id:Int(queryResultCol0))
               
                foodList.append(food)
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
//          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return foodList
        }
    static func getBookItems() ->  [Books] {
        
        let queryStatementString = "SELECT Books.Item_ID,Author,Publisher,year_of_publish,Quantity,Others FROM ItemDetails,Books  WHERE Books.Item_ID IN(SELECT Item_ID FROM DonationStatus WHERE Status = 'pending') OR Books.Item_ID NOT IN(SELECT Item_ID FROM DonationStatus)  and Books.Item_ID = ItemDetails.Item_ID ORDER BY ItemDetails.Item_Name;"
        var bookList : [Books] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_int(queryStatement, 1, Int32(donarid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
            let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                let book : Books = Books(author: String(cString: queryResultCol1!), publisher: String(cString: queryResultCol2!), year_of_publish: String(cString: queryResultCol3!), quantity: Int(queryResultCol4), others: String(cString: queryResultCol5!), item_id:Int(queryResultCol0))
               
                bookList.append(book)
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
//          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return bookList
        }
    static func getClothItems() ->  [Cloth] {
        
        let queryStatementString = "SELECT Cloth.Item_ID,Size,clothCategory,Gender,Quantity,Others FROM ItemDetails,Cloth  WHERE Cloth.Item_ID IN(SELECT Item_ID FROM DonationStatus WHERE Status = 'pending') OR Cloth.Item_ID NOT IN(SELECT Item_ID FROM DonationStatus)  and Cloth.Item_ID = ItemDetails.Item_ID ORDER BY ItemDetails.Item_Name;"
        var clothList : [Cloth] = []
        var queryStatement: OpaquePointer?
          if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) ==
              SQLITE_OK {
           // sqlite3_bind_int(queryStatement, 1, Int32(donarid))
            while sqlite3_step(queryStatement) == SQLITE_ROW {
    
             let queryResultCol0 = sqlite3_column_int(queryStatement, 0)
             let queryResultCol1 = sqlite3_column_text(queryStatement, 1)
             let queryResultCol2 = sqlite3_column_text(queryStatement, 2)
             let queryResultCol3 = sqlite3_column_text(queryStatement, 3)
             let queryResultCol4 = sqlite3_column_int(queryStatement, 4)
            let queryResultCol5 = sqlite3_column_text(queryStatement, 5)
                let cloth : Cloth = Cloth(size: String(cString: queryResultCol1!), clothCategory: String(cString: queryResultCol2!), gender: String(cString: queryResultCol3!), quantity: Int(queryResultCol4), others: String(cString: queryResultCol5!), item_id:Int(queryResultCol0))
               
                clothList.append(cloth)
              
                //return userid
            }
          } else {
            let errorMessage = String(cString: sqlite3_errmsg(db))
            print("\nQuery is not prepared \(errorMessage)")
          }
//          sqlite3_finalize(queryStatement)
//        if sqlite3_close(db) == SQLITE_OK {
//            print("closing database")
//        }
        return clothList
        }
}
