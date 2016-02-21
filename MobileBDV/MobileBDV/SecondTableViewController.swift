//
//  SecondTableViewController.swift
//  MobileBDV
//
//  Created by Brian Thompson on 2/21/16.
//  Copyright © 2016 Brian Thompson. All rights reserved.
//

import Foundation
import UIKit

var SecondArray = [String]()
class SecondTableViewController: UITableViewController {
    
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return SecondArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       
        let cell = self.tableView.dequeueReusableCellWithIdentifier("secondCell", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = SecondArray[indexPath.row]
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        let cellChosen = currentCell.textLabel!.text
        let name = "\(cellChosen!)"
        patientSelected = patientNames[name]

    }
}
