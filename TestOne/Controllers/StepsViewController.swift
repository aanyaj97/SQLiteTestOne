//
//  StepsViewController.swift
//  TestOne
//
//  Created by Aanya Jhaveri on 9/19/18.
//  Copyright © 2018 Aanya Jhaveri. All rights reserved.
//

import UIKit

class StepsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var stepsTitle: UILabel!
    @IBOutlet weak var stepsTable: UITableView!

    var routineNum: Int?
    var data = establishConnection()
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var num = 0
        if let routineNumber = routineNum {
            num = data[routineNumber].1.count
        }
        return num
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StepNameCell", for: indexPath)
        if let routineNumber = routineNum {
            cell.textLabel?.text = "\(data[routineNumber].1[indexPath.row].name)"
        }
        return cell
    }
    

    override func viewDidLoad() {
        if let routineNumber = routineNum {
            title = data[routineNumber].0
            self.stepsTitle.text = title
        }
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
