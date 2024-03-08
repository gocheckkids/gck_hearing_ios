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
    
    var resultCoordinator: (() -> ())?
    var screeningCoordinator: (() -> ())?
    
    init(patient: Patient, resultCoordinator: ( () -> Void)? = nil, screeningCoordinator: ( () -> Void)? = nil, loader: PatientVisitLoader) {
        self.patient = patient
        self.resultCoordinator = resultCoordinator
        self.screeningCoordinator = screeningCoordinator
        self.patientVisitLoader = loader
    }
    
    func getLatestScreenings() async {
        loadState = .loading
        await recentResults = patientVisitLoader.getPatientRecentVisitsSummary(id: patient.id)
        loadState = .success
    }
}
