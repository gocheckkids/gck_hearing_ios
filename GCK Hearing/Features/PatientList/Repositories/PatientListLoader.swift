//
//  PatientListLoader.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation

protocol PatientListLoader {
    func getPatients() async -> [Patient]
}

protocol PatientVisitLoader {
    func getPatientRecentVisitsSummary(id: Int) async -> [ResultsModel]
}

struct ResultsModel: Identifiable {
    var id = UUID()
    
    var date: String
    var referralResult: Bool
    
    init(date: String, referralResult: Bool) {
        self.date = date
        self.referralResult = referralResult
    }
    
    var riskFactorSummary: String {
        return referralResult ? "Risk Factors": "No Risk Factors"
    }
}

// Local Implementation
class LocalPatientListLoader: PatientListLoader {

    
    func getPatients() async -> [Patient] {
        try? await Task.sleep(for: .seconds(2))
        
        return MockData.shared.mockPatientList
        
    }
    
    private func parseJSON(jsonString: String) {
        
    }
}

// Local Implementation
class LocalPatientVisitsLoader: PatientVisitLoader {
    func getPatientRecentVisitsSummary(id: Int) async -> [ResultsModel] {
        try? await Task.sleep(for: .seconds(2))
        return MockData.shared.mockPatientVisits
    }
    

  
}

// API Implementation
class RemotePatientListLoadeer: PatientListLoader {
    
    func getPatients() async -> [Patient] {
        return []
    }
}


