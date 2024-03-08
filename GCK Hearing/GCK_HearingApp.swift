//
//  GCK_HearingApp.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

@main
struct GCK_HearingApp: App { 
    let vm = PatientListViewModel(loader: LocalPatientListLoader())
    let screeningVM = ScreeningViewModel(patient: MockData.shared.mockPatient)
    var body: some Scene {
        WindowGroup {
            ScreeningView(screeningVm: screeningVM)
        }
    }
}
