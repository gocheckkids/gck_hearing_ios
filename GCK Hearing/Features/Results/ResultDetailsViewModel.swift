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
    
    var doneAction: (() -> ())? = {}
    
    init(patient: Patient, results: ResultDetails) {
        self.patient = patient
        self.results = results
    }
}

