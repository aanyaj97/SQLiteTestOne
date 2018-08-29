//
//  SQLiteInterface.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 8/27/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation
import SQLite3

struct Path {
    static let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("RoutineDatabase.sqlite")
}


func openConnection() -> OpaquePointer? {
    var db: OpaquePointer? = nil
    if sqlite3_open(Path.fileURL.path, &db) == SQLITE_OK {
        print("Connection to \(Path.fileURL) successfully opened")
        return db
    } else {
        print("Unable to establish connection to database. Verify that database was created.")
        return db
    }
}


func createTable(name: String, db: OpaquePointer) {
    let stringStatement = "CREATE TABLE IF NOT EXISTS " + name + " ( \n"
        + "Id INT PRIMARY KEY NOT NULL,\n"
        + "NAME CHAR(255));"
    var createPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &createPointer, nil) == SQLITE_OK {
        if sqlite3_step(createPointer) == SQLITE_DONE {
            print("\(name) table created.")
        } else {
            print("\(name) table was not created.")
        }
    } else {
        print("The table already exists or there is an error in the SQLite code.")
    }
    sqlite3_finalize(createPointer)
}

func insertData(table: String, num: Int32, desc: NSString, db: OpaquePointer) {
    let stringStatement = "INSERT OR IGNORE INTO " + table + " (Id, Name) Values (?, ?)"
    var insertPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, stringStatement, -1, &insertPointer, nil) == SQLITE_OK {
        let id = num
        let name = desc
        
        sqlite3_bind_int(insertPointer, 1, id)
        sqlite3_bind_text(insertPointer, 2, name.utf8String, -1, nil)
        
        if sqlite3_step(insertPointer) == SQLITE_DONE {
            print("Sucessfully inserted (\(id), \(name)) into table \(table).")
        } else {
            print("Data could not be inserted.")
        }
    } else {
        print("INSERT statement could not be prepared")
    }
    sqlite3_finalize(insertPointer)
}




