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




