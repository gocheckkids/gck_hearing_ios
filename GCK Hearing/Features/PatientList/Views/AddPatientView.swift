//
//  AddPatientView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/18/24.
//

import Foundation
import SwiftUI

struct AddPatientView: View {
    @ObservedObject var vm: PatientListViewModel
    
    // Add @State vars for Textfield here or in a new ViewModel
    @State private var medicalID = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthdate = Date.now
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Group {
                    TextField("Medical ID?", text: $medicalID)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.numberPad)
                    TextField("First Name", text: $firstName)
                        .textFieldStyle(.roundedBorder)
                    TextField("Last Name", text: $lastName)
                        .textFieldStyle(.roundedBorder)
                    DatePicker(selection: $birthdate, in: ...Date.now, displayedComponents: .date) {
                        Text("Birthdate")
                    }
                    .datePickerStyle(.compact)
                }
                
                RoundedButton(title: "Done", color: .black) {
                    Task {
                        await vm.addPatient(createPatientFromTextfields())
                        vm.doneAddingPatientAction?()
                    }
                }
            }
            .padding(.horizontal)
          
            .navigationTitle("Add Patient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Cancel", color: Color.blueTheme.accentDark) {
                        vm.doneAddingPatientAction?()
                    }
                    
                }
            }
        }
        // Add preconfigured patient for now
      
    }
}

extension AddPatientView {
    private func createPatientFromTextfields() -> Patient {
        // Handle validation elsewhere
        let patient = Patient(id: Int(medicalID) ?? 00, firstName: !firstName.isEmpty ? firstName : "Blank" , lastName: !lastName.isEmpty ? lastName : "Blank", dob: birthdate.formatted(date: .numeric, time: .omitted))
        return patient
    }
}

struct AddPatientPreview: PreviewProvider {
     static var previews: some View {
         AddPatientView(vm: PatientListViewModel(loader: LocalPatientListLoader()))
            .previewLayout(.sizeThatFits)
    }
}
