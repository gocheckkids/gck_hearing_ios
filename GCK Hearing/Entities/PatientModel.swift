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
    var birthdate: Date
    
    
    
//    var age: Int {
//            let now = Date()
//            let calendar = Calendar.current
//            let ageComponents = calendar.dateComponents([.year], from: dob, to: now)
//            return ageComponents.year ?? 0
//        }
    
    var fullName: String {
        return (firstName + " " + lastName)
    }
    
    var dob: String {
        return birthdate.formattedAsDateString()
    }
    
    init(id: Int, firstName: String, lastName: String, birthdate: Date) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.birthdate = birthdate
    }

}
