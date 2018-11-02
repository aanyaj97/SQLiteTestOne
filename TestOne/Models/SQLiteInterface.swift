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
    // establish connection to database
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
    // create a table
    let stringStatement = "CREATE TABLE IF NOT EXISTS [" + name + "] ( \n"
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

func deleteTable(name: String, db: OpaquePointer) {
    // delete a table
    let deleteStatement = "DROP TABLE IF EXISTS [" + name + "]"
    var deletePointer : OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
            print("\(name) table sucessfully deleted")
        } else {
            print("\(name) could not be deleted")
        }
    } else {
        print("Delete statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

func returnTables(db: OpaquePointer) -> [String] {
    // return table data
    var tables: [String] = []
    let returnStatement = "SELECT name FROM sqlite_master where type = 'table'"
    var returnPointer : OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -1, &returnPointer, nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let cText = sqlite3_column_text(returnPointer, 0)
            let title = String(cString: cText!)
            tables.append(title)
        }
    }  else {
        print("Table names could not be returned.")
    }
    sqlite3_finalize(returnPointer)
    return tables
}

func renameTable(oldName: String, newName: String, db: OpaquePointer?) {
    // change name of table
    let renameStatement = "ALTER TABLE [" + oldName + "] \n"
        + "RENAME TO [" + newName + "];"
    var renamePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, renameStatement, -1, &renamePointer, nil) == SQLITE_OK {
        if sqlite3_step(renamePointer) == SQLITE_DONE {
            print("\(oldName) sucessfully renamed as \(newName)")
        } else {
            print("Table could not be renamed.")
        }
    } else {
        print("Rename statement could not be prepared.")
    }
    sqlite3_finalize(renamePointer)
}

func insertData(table: String, num: Int32, desc: NSString, db: OpaquePointer) {
    // add step to table
    let stringStatement = "INSERT OR IGNORE INTO [" + table + "] (Id, Name) Values (?, ?)"
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

func returnData(table: String, db: OpaquePointer) -> [Routine] {
    // return steps from table
    var routineResult: [Routine] = []
    let returnStatement = "SELECT * FROM [" + table + "];"
    var returnPointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, returnStatement, -2, &returnPointer,  nil) == SQLITE_OK {
        while sqlite3_step(returnPointer) == SQLITE_ROW {
            let id = sqlite3_column_int(returnPointer, 0)
            let cText = sqlite3_column_text(returnPointer, 1)
            let name = String(cString: cText!)
            routineResult.append(Routine(id: Int(id), name: name))
        }
    } else {
        print("SELECT statement could not be prepared.")
    }
    sqlite3_finalize(returnPointer)
    return routineResult
}

func deleteData(table: String, id: Int32, db: OpaquePointer) {
    // delete row from table
    let deleteStatement = "DELETE FROM [" + table + "] WHERE Id = " + String(id) + ";"
    var deletePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, deleteStatement, -1, &deletePointer, nil) == SQLITE_OK {
        if sqlite3_step(deletePointer) == SQLITE_DONE {
          print("Row deleted.")
        } else {
            print("Row could not be deleted.")
        }
    } else {
        print("DELETE statement could not be prepared.")
    }
    sqlite3_finalize(deletePointer)
}

func updateData(name: String, table: String, id: Int32, db: OpaquePointer) {
    // update row from table
    let updateStatement = "UPDATE [" + table + "] SET Name = '" + name + "' WHERE Id = " + String(id) + ";"
    var updatePointer: OpaquePointer? = nil
    if sqlite3_prepare_v2(db, updateStatement, -1, &updatePointer, nil) == SQLITE_OK {
        if sqlite3_step(updatePointer) == SQLITE_DONE {
            print("Successfully updated row.")
        } else {
            print("Row could not be updated.")
        }
    } else {
        print("UPDATE statement could not be prepared.")
    }
    sqlite3_finalize(updatePointer)
}



//set up error handling
//maybe just one function to output the relevant string: switch case
//close connection !!


//ello
