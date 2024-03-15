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
    func getPatients() async -> [Patient]
}

// Local Implementation
class LocalPatientListLoader: PatientListLoader {
    func getPatients() async -> [Patient] {
//        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockPatientList
    }
}

// API Implementation
class RemotePatientListLoadeer: PatientListLoader {
    
    func getPatients() async -> [Patient] {
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








