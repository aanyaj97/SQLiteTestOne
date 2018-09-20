//
//  ViewController.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 8/27/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var routineTable: UITableView!
    
    var data = establishConnection() //make this into a struct eventually
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows: Int = 0
        
        if section < data.count {
            rows = data[section].1.count
        }
        return rows
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineNameCell", for: indexPath)
        let routine = indexPath.section
        let step = indexPath.row
        
        cell.textLabel?.text = "Routine: \(data[routine].0) - Task: \(data[routine].1[step].name)" //will change the section thing to the table name at top
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let routine = data[section].0
        return routine
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let svc = storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as? StepsViewController {
            svc.routineNum = indexPath.section
            navigationController?.pushViewController(svc, animated: true)
            }
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController {
    @IBAction func backToRoutineViewController(_ segue: UIStoryboardSegue) {
    }
}
