//
//  FirstTableViewController.swift
//  MobileBDV
//
//  Created by Brian Thompson on 2/21/16.
//  Copyright © 2016 Brian Thompson. All rights reserved.
//

import UIKit

var patients = [Patient]()
var patientCreater = PatientCreater()


func initPatient(){
    patientCreater.readDataBase(patients)
}

class FirstTableViewController: UITableViewController, returnPatientArray {

    var FirstTableArray = [String]()
    var flag = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patientCreater = PatientCreater()
        patientCreater.delegate = self
        FirstTableArray = ["Load Patients"]
        
        initPatient()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirstTableArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let Cell = self.tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        Cell.textLabel?.text = FirstTableArray[indexPath.row]
        
        return Cell
    }
    
    func patientArrayValue(returnedValue: [Patient]) {
        patients = returnedValue;
        for patient in patients{
            SecondArray.append(patient.givenName+" "+patient.familyName)
            patientNames[patient.givenName+" "+patient.familyName] = patient
        }
    }


}
