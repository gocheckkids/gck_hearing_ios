//
//  RootCoordinator.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/11/24.
//

import SwiftUI

struct CoordinatorView: View {
    @ObservedObject var object: CoordinatorObject
    var body: some View {
        NavigationView {
            PatientListScreen(vm: object.patientListVM)
                .navigation(item: $object.patientDetailVM) { vm in PatientDetailView(detailVm: vm) }
        }
    }
}

struct CoordinatorPreview: PreviewProvider {

     static var previews: some View {
         CoordinatorView(object: CoordinatorObject(listLoader: LocalPatientListLoader(), visitLoader: LocalPatientVisitsLoader()))
            .previewLayout(.sizeThatFits)
    }
}

class CoordinatorObject: ObservableObject, Identifiable {

    @Published var patientListVM: PatientListViewModel!
    @Published var patientDetailVM: PatientDetailViewModel?
    @Published var screeningVM: ScreeningViewModel?
    @Published var resultVM: ResultDetailsViewModel?
    
    private let listLoader: PatientListLoader
    private let visitLoader: PatientVisitLoader

    init(listLoader: PatientListLoader, visitLoader: PatientVisitLoader) {
        self.listLoader = listLoader
        self.visitLoader = visitLoader
        self.patientListVM = PatientListViewModel(loader: listLoader, coordinator: self)
        
    }

    func openDetails(_ patient: Patient) {
        print("open details")
        self.patientDetailVM = PatientDetailViewModel(patient: patient, screeningCoordinator: self, loader: visitLoader)
    }
    
    func openScreening(for patient: Patient) {
        
    }
    
    func openResults(for patient: Patient, _ data: ResultDetails) {
        
    }
}





