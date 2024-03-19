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
    var allPatients: [Patient] = []
    @Published var searchText = ""
    
    var userTapAction: ((Patient) -> ())? = { _ in }
    var screenTapAction: ((Patient) -> ())? = { _ in }
    
    // Isolate to a Menu coordinator
    var addPatientAction: (() -> ())? = {}
    var doneAddingPatientAction: (() -> ())? = {}
    
    var patientListLoader: PatientListLoader
    
    init(loader: PatientListLoader) {
        self.patientListLoader = loader
    }
    
    @MainActor
    func loadPatients() async {
            loadState = .loading
            await allPatients = patientListLoader.getPatients()
            loadState = .success
    }
    
    // should be a network call, update in DB, then update on screen
    func addPatient(_ patient: Patient) async {
        await patientListLoader.addPatient(patient)
    }
}
