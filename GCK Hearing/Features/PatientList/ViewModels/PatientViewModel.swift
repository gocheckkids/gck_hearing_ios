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
  
    var allPatients: [DayVisits] = []
   
    var userTapAction: ((Patient) -> ())? = { _ in }
    var screenTapAction: ((Patient) -> ())? = { _ in }
    
    // Isolate to a Menu coordinator
    var addPatientAction: (() -> ())? = {}
    var doneAddingPatientAction: (() -> ())? = {}
    
    var patientListLoader: PatientRepository
    
    init(loader: PatientRepository) {
        self.patientListLoader = loader
        setupDebounce()
    }
    
    @MainActor
    func loadPatients() async {
            loadState = .loading
            await allPatients = patientListLoader.getPatients()
            loadState = .success
    }
    
    // MARK: Patient Add
    
    // should be a network call, update in DB, then update on screen
    func addPatient(_ patient: Patient) async {
        await patientListLoader.addPatient(patient)
        
        await MainActor.run {
            doneAddingPatientAction?() 
        }
    }
    
    // MARK: Patient Search
    var filteredPatients: [DayVisits] = []
    @Published var isSearching: Bool = false
    
    @Published var searchText = "" {
        didSet {
            isSearching = !searchText.isEmpty ? true : false
        }
    }
    
    @Published var debouncedSearchText = ""
    
    func setupDebounce() {
        debouncedSearchText = self.searchText
        $searchText
            .debounce(for: .seconds(0.75), scheduler: RunLoop.main)
            .assign(to: &$debouncedSearchText)
    }
    func searchPatient(keyword: String) async {
//        loadState = .loading
//        try? await Task.sleep(seconds: 1)
        isSearching = true
        print("Search using \(keyword)")
        await filteredPatients = patientListLoader.searchPatient(keyword: keyword)
//        loadState = .success
    }
}
