//
//  SQLiteDataControl.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 9/17/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

let db = openConnection()

func establishConnection() -> [(String,[Routine])]  {
    var routines : [(String,[Routine])] = []
    if let database = db {
        let names = returnTables(db: database)
        for i in 0...(names.count-1) {
            let title = names[i]
            routines.append((title, returnData(table: title, db: database)))
        }
    }
    return routines
}


