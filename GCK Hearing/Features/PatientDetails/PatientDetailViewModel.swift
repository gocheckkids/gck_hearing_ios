//
//  PatientDetailViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/7/24.
//

import Foundation

class PatientDetailViewModel: ObservableObject {
    
    enum PatientVisitsLoadingState {
        case loading, success, failed
    }

    @Published var patient: Patient
    @Published var loadState = PatientVisitsLoadingState.loading
    
    var patientVisitLoader: PatientVisitLoader

    // Belongs in View Model instead?
    @Published var recentResults:[ResultsModel] = []
    
    var backAction: (() -> ())? = {}
    var tapScreeningAction: ((Patient) -> ())? = {_ in}
    var tapResultAction: (() -> ())? = {}
    
    init(patient: Patient, loader: PatientVisitLoader) {
//        self.screeningCoordinator = screeningCoordinator
        self.patient = patient
        self.patientVisitLoader = loader
    }
    
    func getLatestScreenings() async {
        loadState = .loading
        await recentResults = patientVisitLoader.getPatientRecentVisitsSummary(id: patient.id)
        loadState = .success
    }
}
