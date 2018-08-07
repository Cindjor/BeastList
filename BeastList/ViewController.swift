//
//  ViewController.swift
//  BeastList
//
//  Created by Luke CHEUNG on 11/13/15.
//  Copyright © 2015 LuCH. All rights reserved.
//

import UIKit

var DB = Database()

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var insertTaskField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
       var tasks = ["Exercise for 30 minutes", "Wireframe for some project", "Do laundry"]
    
    // these 2 functions are needed to MAKE the table view begin
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    @IBAction func insertButtonPressed(sender: UIButton) {
        //if let newtask = insertTaskfield.text {
//                tasks.append(newtask) }
        // tableview.reloadData()
        
        if let newTask = insertTaskField.text {
            tasks.append(newTask)
            Task.encodeWithCoder(insertTaskField.text)
        }
       tableView.reloadData()
        insertTaskField.text = ""
    }

    // this actually is creating cells, iterates the cells with n value for for loop
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        print("creating the cell at row \(indexPath.row) with text as \(tasks[indexPath.row])")
        let cell = tableView.dequeueReusableCellWithIdentifier("MyCell")!
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    //end
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Section: \(indexPath.section) and Row: \(indexPath.row)")
        tasks.removeAtIndex(indexPath.row)
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

