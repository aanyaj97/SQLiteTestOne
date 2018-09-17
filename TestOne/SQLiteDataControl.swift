//
//  SQLiteDataControl.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 9/17/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import Foundation

let db = openConnection()

func establishConnection() -> [Routine]  {
    if let database = db {
        let result = returnData(table: "Name", db: database)
        return result
    } else {
        return []
    }
}


