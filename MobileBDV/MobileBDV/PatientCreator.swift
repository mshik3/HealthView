//
//  PatientCreator.swift
//  MobileBDV
//
//  Created by Brian Thompson on 2/20/16.
//  Copyright © 2016 Brian Thompson. All rights reserved.
//

import Foundation
import Firebase


protocol returnPatientArray {
    func patientArrayValue(returnedValue: [Patient])
}

class PatientCreater: NSObject {
    let ref = Firebase(url: "https://bdv.firebaseio.com/")
    
    var delegate: returnPatientArray?
    
    var sectiond: Section!
    var patient: Patient!
    
    func readDataBase(var patientse: [Patient]){
        ref.observeEventType(.Value, withBlock: {
            snapshot in
            
            
            let json = JSON(snapshot.value)
            for item in json["patients"]{
                //Build each section
                var sections = [Section]()
                for section in item.1["sections"]{
                    let enteredName=section.1["enteredName"]
                    let enteredDate=section.1["enteredDate"]
                    let translationName=section.1["translationName"]
                    let IMO_LEXICAL_CODE=section.1["IMO_LEXICAL_CODE"]
                    let ICD10CM_CODE=section.1["ICD10CM_CODE"]
                    //print(section.1)
                    self.sectiond = Section.init(enteredName: String(enteredName), translationName: String(translationName), IMO_LEXICAL_CODE: String(IMO_LEXICAL_CODE), ICD10CM_CODE: String(ICD10CM_CODE), enteredDate: String(enteredDate))
                    sections.append(self.sectiond)
                }
                //Build Patient
                let effectiveTime = item.1["clinicalDocument"]["effectiveTime"]
                var patientInfo = item.1["clinicalDocument"]["patientInformation"]
                let givenName = patientInfo["name"]["firstname"]
                let familyName = patientInfo["name"]["family"]
                let gender = patientInfo["gender"]
                let dateOfBirth = patientInfo["dateOfBirth"]
                self.patient = Patient.init(givenName: String(givenName), familyName: String(familyName), dateOfBirth: String(dateOfBirth), gender: String(gender), effectiveTime: String(effectiveTime), Sections: sections)
                patientse.append(self.patient)
            }
            self.delegate?.patientArrayValue(patientse)
            
        })
    }

}


