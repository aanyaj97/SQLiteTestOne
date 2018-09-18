//
//  RoutineTableViewController.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 9/17/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class RoutineTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    var data = establishConnection()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < data.count {
            rows = data[section].1.count
        }
        return rows
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineCell", for: indexPath)
        let routine = indexPath.section
        let step = indexPath.row

        cell.textLabel?.text = "Routine: \(data[routine].0) - Task: \(data[routine].1[step].name)" //will change the section thing to the table name at top

        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let routine = data[section].0
        return routine
    }
}
