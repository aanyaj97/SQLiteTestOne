//
//  ViewController.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 8/27/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let db = openConnection()
        if let database = db {
            createTable(name: "Name", db: database)
        } else {
            print("Database connection not established; cannot add table")
        }
        let dataOne = Routine(id: 1, name: "Stretch")
        
        if let database = db {
            insertData(table: "Name", num: Int32(dataOne.id), desc: dataOne.name as NSString, db: database)
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

