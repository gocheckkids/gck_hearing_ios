//
//  ResultDetailsViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/8/24.
//

import Foundation

class ResultDetailsViewModel : ObservableObject {
    let patient: Patient
    let results: ResultDetails
    
    init(patient: Patient, results: ResultDetails) {
        self.patient = patient
        self.results = results
    }
}

struct ResultDetails {
    var date: String
    var leftEarResultMap: Dictionary<Int, Bool> = [:]
    var rightEarResultMap: Dictionary<Int, Bool> = [:]
    
    var hasRiskFactor: Bool = false
}
