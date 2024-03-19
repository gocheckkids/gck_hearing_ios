//
//  PatientListView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

struct PatientListScreen: View {
    @ObservedObject var vm: PatientListViewModel
    
    init(vm: PatientListViewModel) {
        self.vm = vm
    }
    
    var body: some View {
        NavigationView {
            VStack {
                //                SearchBarView(searchText: $vm.searchText, placeholderText: "Search for a patient ...")
                //                Spacer()
                //                .padding(.bottom, 20)
                List {
                    switch vm.loadState {
                    case .loading:
                        PatientListLoadingView()
                    case .success:
                        ForEach(vm.allPatients) { dayVisit in
                            PatientListLoadedView(visits: dayVisit, detailAction: { patient in
                                vm.userTapAction?(patient)
                            }, screenAction: { patient in
                                vm.screenTapAction?(patient)
                            })
                        }
                        
                    case .failed:
                        PatientListErrorView()
                    }
                }
                .searchable(text: $vm.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Find patient by name or ID")
                .listStyle(.plain)
            }
            .navigationTitle("Patients")
            .navigationBarTitleDisplayMode(.inline)
            
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Menu", color: Color.deepBlueTheme.accentDark, action: {})
                }
                ToolbarItem(placement: .topBarTrailing) {
                    RoundedButton(title: "Add", color: Color.blueTheme.accentDark, action: {
                        vm.addPatientAction?()
                    })
                }
            }
            .onAppear {
                Task {
                    await vm.loadPatients()
                }
            }
        }
        
    }
}

extension PatientListScreen {
    struct PatientListLoadingView: View {
        var body: some View {
            ProgressView()
                .frame(maxWidth: .infinity)
                .padding()
        }
    }
    
    struct PatientListLoadedView: View {
        let visits: DayVisits
        
        let detailAction: (Patient) -> Void
        let screenAction: (Patient) -> Void
        
        var body: some View {
            Section {
                ForEach(visits.patientList) { patient in
                        HStack {
                            PatientRow(patientName: patient.fullName)
                                .onTapGesture {
                                    detailAction(patient)
                                }
                            Spacer()
                            RoundedButton(title: "Screen", color: .theme.accent) {
                                // screenaction
                                screenAction(patient)
                            }
                        }
                    }
                   
                
                .listRowInsets(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
                .listRowSeparator(.hidden, edges: .all)
            } header: {
                Text(visits.visitDate.formatted(date: .abbreviated, time: .omitted))
                //                .frame(maxWidth: .infinity, alignment: .leading)
                //                .background(.teal)
            }
        }
    }
    
    struct PatientListErrorView: View {
        var body: some View {
            Text("Error fetching data!")
        }
    }
}

struct PatientRow: View {
    let patientName: String
    
    var body: some View {
        Text(patientName)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(8)
        .background(Color.blueTheme.background)
//        .border(.green, width: 4)
        .cornerRadius(5)
    }
}


#Preview {
    PatientListScreen(vm: PatientListViewModel(loader: LocalPatientListLoader()))
}

//#Preview(traits: .sizeThatFitsLayout) {
//    PatientRow(patientName: "Sammy Longjohn")
//}
//
//#Preview(traits: .sizeThatFitsLayout) {
//    List {
//        PatientListLoadedView(patientList: MockData.shared.mockPatientList, dateString: "02-03-2024", action: {})
//    }
//    .listStyle(.plain)
//}
