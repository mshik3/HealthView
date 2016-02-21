//
//  Patient.swift
//  BDV
//
//  Created by Brian Thompson on 2/20/16.
//  Copyright © 2016 Brian Thompson. All rights reserved.
//

import Foundation


struct Patient {
    var givenName: String
    var familyName: String
    var dateOfBirth: String
    var gender: String
    var effectiveTime: String
    var Sections: [Section]

    

    init(givenName: String,familyName: String,dateOfBirth: String,gender: String,effectiveTime: String,Sections: [Section]) {
        self.givenName=givenName
        self.familyName=familyName
        self.dateOfBirth=dateOfBirth
        self.gender=gender
        self.effectiveTime=effectiveTime
        self.Sections=Sections
    }
}