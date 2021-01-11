//
//  DataBaseUtils.swift
//  Task1_SSD
//
//  Created by Mukhammadjon Askarov on 09/01/21.
//

import Foundation
import SQLite3

class DBHelper
{
    init()
    {
        db = openDatabase()
        createUserTable()
        createItemsTable()
    }
    
    let dbPath: String = "myDb.sqlite"
    var db:OpaquePointer?
    
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createUserTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS user(Id  INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT,dateCreatedAt INTEGER);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("user table created.")
            } else {
                print("user table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    func createItemsTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS Items(Id  INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("items table created.")
            } else {
                print("items table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insertIntoUser( name:String, createdAt:String)
    {
        let insertStatementString = "INSERT INTO user (name, dateCreatedAt) VALUES ( ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (createdAt as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                //      print("name : \(name) - age:  \(age)  ")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    
    func insertIntoItems( name:String)
    {
        let insertStatementString = "INSERT INTO items (name) VALUES (?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
                //      print("name : \(name) - age:  \(age)  ")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func readUserTable(page: Int, pageSize: Int) -> [User]  {
        let queryStatementString = "SELECT * FROM user ORDER BY id DESC LIMIT \(pageSize) OFFSET \(page*pageSize);"
        var queryStatement: OpaquePointer? = nil
        var users : [User] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let dateCreatedAt = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
            
                users.append(User(name: name, dateCreatedAt: dateCreatedAt))
                
                print("Query Result:")
                print("\(id) | \(name) | \(dateCreatedAt)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return users
    }
    
    func readItemsTable(page: Int, pageSize: Int) -> [Items]  {
        let queryStatementString = "SELECT * FROM items ORDER BY id DESC LIMIT \(pageSize) OFFSET \(page*pageSize);"
        var queryStatement: OpaquePointer? = nil
        var items : [Items] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                items.append(Items(itemName: String(name), id: Int(id)))
                
                print("Query Result:")
                print("\(id) | \(name)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return items
    }
    
    
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }

//
//    func update(id:Int , name:String, age:Int) {
//        let updateStatementString = "UPDATE person SET name = ? , age = ? WHERE Id = \(id);"
//
//        var updateStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) == SQLITE_OK {
//
//            sqlite3_bind_text(updateStatement, 1, ( name as NSString).utf8String, -1, nil)
//            sqlite3_bind_int(updateStatement, 2, Int32( age))
//
//            if sqlite3_step(updateStatement) == SQLITE_DONE {
//                print("Successfully updated row.")
//                //      print("name : \(name) - age:  \(age)  ")
//            } else {
//                print("Could not update row.")
//            }
//        } else {
//            print("Update statement could not be prepared.")
//        }
//        sqlite3_finalize(updateStatement)
//
//    }

    
}
