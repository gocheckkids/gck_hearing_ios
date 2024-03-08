//
//  PatientModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation

struct Patient:Identifiable {
    
    var id: Int
    var firstName: String
    var lastName: String
    var dob: String
    
//    var age: Int {
//            let now = Date()
//            let calendar = Calendar.current
//            let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
//            return ageComponents.year ?? 0
//        }
    
    var fullName: String {
        return (firstName + " " + lastName)
    }
    
    init(id: Int, firstName: String, lastName: String, dob: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.dob = dob
    }
    
    
}
