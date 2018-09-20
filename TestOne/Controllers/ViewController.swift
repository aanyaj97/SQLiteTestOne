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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoutineNameCell", for: indexPath)
        let routine = indexPath.row
        
        cell.textLabel?.text = "Routine: \(data[routine].0)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let svc = storyboard?.instantiateViewController(withIdentifier: "StepsViewController") as? StepsViewController {
            svc.routineNum = indexPath.row
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
