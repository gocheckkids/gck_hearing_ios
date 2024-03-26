//
//  PatientListLoader.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import Foundation

// MARK: Location List

protocol LocationListLoader {
    func getLocations() async -> [String]
}

class LocalLocationListLoader: LocationListLoader {
    func getLocations() async -> [String] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockLocationList
    }
}

// MARK: Patient List

protocol PatientRepository {
    func getPatients() async -> [DayVisits]
    func addPatient(_ patient: Patient) async -> ()
    func searchPatient(keyword: String) async -> [DayVisits]
}

// Local Implementation
class LocalPatientListLoader: PatientRepository {
    func searchPatient(keyword: String) async -> [DayVisits] {
        var returnVisits: [DayVisits] = []
        let key = keyword.lowercased()

        MockData.shared.mockDayVisitsList.forEach { visit in
            var patientsList = [Patient]()
            patientsList = visit.patientList.filter { patient in
                patient.firstName.lowercased().contains(key) ||
                patient.lastName.lowercased().contains(key) ||
                String(patient.id).contains(key)
            }
            // Found at least 1 match
            if !patientsList.isEmpty {
                returnVisits.append(DayVisits(visitDate: visit.visitDate, patientList: patientsList))
                // empty list for next check
//                patientsList = []
            }
        }
        return returnVisits
    }
    
    func addPatient(_ patient: Patient) async {
        let latestDate = MockData.shared.mockDayVisitsList[0].visitDate
        // Is the latest list on today's date? If so add to top, if not, create new dayvisit.
        
        // Add to the end of today's list
        if (latestDate.isCurrentDay()) {
            MockData.shared.mockDayVisitsList[0].patientList.append(patient)
        }
        else {
            // Add DayVisit to start of visits array
            MockData.shared.mockDayVisitsList.insert(DayVisits(visitDate: Date.now, patientList: [patient]), at: 0)
        }
    }
    
    func getPatients() async -> [DayVisits] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockDayVisitsList
    }
}

class RemotePatientListLoadeer: PatientRepository {
    func searchPatient(keyword: String) async -> [DayVisits] {
        return []
    }
    
    func addPatient(_ patient: Patient) async {
        // Add patient through API
    }

    func getPatients() async -> [DayVisits] {
        // Load patients using API
        return []
    }
}

// MARK: Patient Recent Visits

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

// MARK: Screening

protocol ScreeningRepository {
    func loadProtocols() async -> [String]
}

class LocalScreeningRepository: ScreeningRepository {
    func loadProtocols() async -> [String] {
        try? await Task.sleep(seconds: 2)
        return MockData.shared.mockScreeningProtocolsList
    }
}








