//
//  PatientListLoader.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation


protocol LocationListLoader {
    func getLocations() async -> [String]
}

class LocalLocationListLoader: LocationListLoader {
    func getLocations() async -> [String] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockLocationList
    }
}

protocol PatientListLoader {
    func getPatients() async -> [DayVisits]
    func addPatient(_ patient: Patient) async -> ()
}


// Local Implementation
class LocalPatientListLoader: PatientListLoader {
    func addPatient(_ patient: Patient) async {
        // Add to start of array to mimic latest patient add
//        MockData.shared.mockPatientList.insert(patient, at: 0)
    }
    
    func getPatients() async -> [DayVisits] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockDayVisitsList
    }
}

// API Implementation
class RemotePatientListLoadeer: PatientListLoader {
    func addPatient(_ patient: Patient) async {
        // Add patient through API
    }
    
    
    func getPatients() async -> [DayVisits] {
        // Load patients using API
        return []
    }
}

protocol PatientVisitLoader {
    func getPatientRecentVisitsSummary(id: Int) async -> [ResultsModel]
}

// Local Implementation
class LocalPatientVisitsLoader: PatientVisitLoader {
    func getPatientRecentVisitsSummary(id: Int) async -> [ResultsModel] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockPatientVisits
    }
}








