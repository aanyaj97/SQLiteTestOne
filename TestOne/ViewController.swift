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
        let dataOne = Routine(id: 2, name: "1 min plank")
        if let database = db {
            createTable(name: "Name", db: database)
            insertData(table: "Name", num: Int32(dataOne.id), desc: dataOne.name as NSString, db: database)
            let result = returnData(table: "Name", db: database)
            for i in result {
                print(i.id)
                print(i.name)
            }
            
        } else {
            print("Database connection not established; cannot add table")
        }
        
        
       
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

