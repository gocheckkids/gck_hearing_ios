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
                        PatientListLoadedView(patientList: vm.allPatients, date: "02/11/2024")
                        PatientListLoadedView(patientList: vm.allPatients, date: "02/07/2024")
                        PatientListLoadedView(patientList: vm.allPatients, date: "02/03/2024")
                    case .failed:
                        PatientListErrorView()
                    }
                }
                .listStyle(.plain)
            }
            
            .navigationTitle("Patients")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Menu", color: .cyan, action: {})
                }
                ToolbarItem(placement: .topBarTrailing) {
                    RoundedButton(title: "Add", color: .cyan, action: {})
                }
            }
        }
        .onAppear {
            Task {
                await vm.loadPatients()
            }
        }
        .searchable(text: $vm.searchText, prompt: "Find patient by name or ID")
    }
}

struct PatientListLoadingView: View {
    var body: some View {
        ProgressView()
    }
}

struct PatientListLoadedView: View {
    let patientList: [Patient]
    let dateString: String
    
    init(patientList: [Patient], date: String) {
        self.patientList = patientList
        self.dateString = date
    }
    
    var body: some View {
        Section {
            ForEach(patientList) { patient in
                PatientRow(patientName: patient.fullName)
            }
            .listRowInsets(.init(top: 0, leading: 10, bottom: 5, trailing: 10))
            .listRowSeparator(.hidden, edges: .all)
        } header: {
            Text(dateString)
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

struct PatientRow: View {
    let patientName: String
    
    init(patientName: String) {
        
        self.patientName = patientName
    }
    
    var body: some View {
        HStack {
//            Text(patientName)
//                .onTapGesture {
//                    print("Go to details for: \(patientName)")
//                }
//                .padding(20)
//                .background(Color.cyan)
            
            Button {
                
            } label: {
                Text(patientName)
                    .foregroundStyle(.white)
                    
//                    .background(.cyan)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(8)
            .background(.cyan)
            .border(.green, width: 4)
            .cornerRadius(5)
            Spacer()
            RoundedButton(title: "Screen", color: .cyan) {
                print("Express screen: \(patientName)")
            }
        }
        
//        .border(.black)
        
    }
}


#Preview {
    PatientListScreen(vm: PatientListViewModel(loader: LocalPatientListLoader()))
}

#Preview(traits: .sizeThatFitsLayout) {
    PatientRow(patientName: "Sammy Longjohn")
}

#Preview(traits: .sizeThatFitsLayout) {
    List {
        PatientListLoadedView(patientList: MockData.shared.mockPatientList, date: "02/21/2024")
    }
    .listStyle(.plain)
}
