//
//  DayVisitModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/19/24.
//

import Foundation

struct DayVisits: Identifiable {
    
    var id = UUID()
    
    //EX) 3/5/24 -> [P1, P2, P5]
    var visitDate: Date
    var patientList: [Patient]
}
