//
//  PatientDetailViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/7/24.
//

import Foundation

class PatientDetailViewModel: ObservableObject {
    
    @MainActor
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
        await updateLoadState(to: .loading)
         
        let fetchedResults = await patientVisitLoader.getPatientRecentVisitsSummary(id: patient.id)
        
        await MainActor.run { [weak self] in
            self?.recentResults = fetchedResults
            self?.loadState = .success
        }
    }
    
    @MainActor
    private func updateLoadState(to state: PatientVisitsLoadingState) {
        loadState = state
    }
}
