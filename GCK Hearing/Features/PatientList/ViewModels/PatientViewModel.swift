//
//  PatientViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation

class PatientListViewModel: ObservableObject {
    
    enum PatientListLoadingState {
        case loading, success, failed
    }
    
    @Published var loadState = PatientListLoadingState.loading
    @Published var allPatients: [Patient] = []
    @Published var searchText = ""
    
    var patientListLoader: PatientListLoader
    
    init(loader: PatientListLoader) {
        self.patientListLoader = loader

    }
    
    func loadPatients() async {
        loadState = .loading
        await allPatients = patientListLoader.getPatients()
        loadState = .success
    }
}
