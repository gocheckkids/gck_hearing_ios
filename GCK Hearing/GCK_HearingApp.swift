//
//  GCK_HearingApp.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

@main
struct GCK_HearingApp: App { 
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
//    let patientListVM = PatientListViewModel(loader: LocalPatientListLoader(), coordinator: CoordinatorObject(visitLoader: LocalPatientVisitsLoader()))
//    let screeningVM = ScreeningViewModel(patient: MockData.shared.mockPatient)
//    let locationVM = MultiLocationViewModel(loader: LocalLocationListLoader())
//    
//    @StateObject var coordinator = CoordinatorObject(listLoader: LocalPatientListLoader(), visitLoader: LocalPatientVisitsLoader())
//    
//    @ObservedObject var loginVM = LoginViewModel()
    
    var body: some Scene {
        WindowGroup {
//            if loginVM.isLoggedIn {
////                CoordinatorView(object: coordinator)
//                MultiLocationListView(locationVM: locationVM)
//            }
//            else {
//                LoginView(loginVM: loginVM)
//            }
        }
    }
}
