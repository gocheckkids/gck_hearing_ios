//
//  GCK_HearingApp.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

@main
struct GCK_HearingApp: App { 
//    let patientListVM = PatientListViewModel(loader: LocalPatientListLoader(), coordinator: CoordinatorObject(visitLoader: LocalPatientVisitsLoader()))
    let screeningVM = ScreeningViewModel(patient: MockData.shared.mockPatient)
    
    @StateObject var coordinator = CoordinatorObject(listLoader: LocalPatientListLoader(), visitLoader: LocalPatientVisitsLoader())
    
    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
            if loginVM.isLoggedIn {
                CoordinatorView(object: coordinator)
            }
            else {
                LoginView(loginVM: loginVM)
            }
        }
    }
}

/* 
 Route flow
 - start w/ login
 -> logged in?
 -> patientCoordinator creates patientlistview
 
 */
