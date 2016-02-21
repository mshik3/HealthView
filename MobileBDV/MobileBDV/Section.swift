//
//  Section.swift
//  MobileBDV
//
//  Created by Brian Thompson on 2/20/16.
//  Copyright © 2016 Brian Thompson. All rights reserved.
//

import Foundation

struct Section {
    var enteredDate: String
    var enteredName: String
    var translationName: String
    var IMO_LEXICAL_CODE: String
    var ICD10CM_CODE: String
    
    init(enteredName: String,translationName: String,IMO_LEXICAL_CODE: String, ICD10CM_CODE: String, enteredDate: String){
        self.enteredDate = enteredDate
        self.enteredName=enteredName
        self.translationName=translationName
        self.IMO_LEXICAL_CODE=IMO_LEXICAL_CODE
        self.ICD10CM_CODE=ICD10CM_CODE
    }
}