//
//  AddPatientView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/18/24.
//

import Foundation
import SwiftUI

struct AddPatientView: View {
//    @ObservedObject var vm: PatientListViewModel
    
    var cancelAction: (() -> ())
    var submitAction: ((Patient) async -> ())
    
    // TODO: Move to a View Model
    @State private var medicalID = ""
    @State private var ethnicity = ""
    @State private var firstName = ""
    @State private var lastName = ""
    
    @State private var birthdate = Date.now
    @State private var birthdateString = ""
    
    @State var selection = ""
    let locations = ["Nashville", "New York", "Texas", "Florida", "Canada"]
    
    @State var genderSelection: String?
    let genders = ["Male", "Female"]
    
    @State var ethnicitySelection: String?
    
    let ethnicities = ["African American", "Asian", "Caucasian","Hispanic","Native American", "Pacific Islander"]
    
    var body: some View {
        NavigationView {
            ScrollView([], showsIndicators: false) {
                VStack(spacing: 30) {
                    inputFieldsGroup
                    Spacer()
                    actionButtonsRow
                }
                .padding(.top, UIScreen.main.bounds.height / 10)
            }
            .padding(.horizontal)
            .navigationTitle("Add a Patient")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Menu", color: Color.blueTheme.accentDark) {
                    }
                }
            }
        }
    }
}

extension AddPatientView {
    private var actionButtonsRow: some View {
        HStack(spacing: 100) {
            RoundedButton(title: "Cancel", color: Color.blueTheme.accentDark) {
//                vm.doneAddingPatientAction?()
                cancelAction()
            }
            RoundedButton(title: "Submit", color: .blueTheme.background) {
                Task {
//                    await vm.addPatient(createPatientFromTextfields())
//                    vm.doneAddingPatientAction?()
                    await submitAction(createPatientFromTextfields())
                }
                
            }
        }
    }
}

extension AddPatientView {
    private var inputFieldsGroup: some View {
        Group {
            PatientInputField(label: "First Name*") {
                TextField("First Name", text: $firstName)
                    .padding(12)
                    .border(.gray)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled(true)
            }
            
            PatientInputField(label: "Last Name*") {
                TextField("Last Name", text: $lastName)
                    .padding(12)
                    .border(.gray)
                    .keyboardType(.alphabet)
                    .autocorrectionDisabled(true)
            }
            
            PatientInputField(label: "Date of Birth*") {
                DateTextField(date: $birthdate, dateString: $birthdateString) {
                    birthdateString = birthdate.toMMDDYYYYString()
                }
                .placeholder("MM/DD/YYYY")
                .padding(12)
                .border(.gray)
            }
            PatientInputField(label: "Medical ID") {
                TextField("Medical ID", text: $medicalID)
                    .padding(12)
                    .border(.gray)
                    .keyboardType(.numberPad)
            }
            PatientInputField(label: "Ethnicity") {
                Picker("", selection: $selection) {
                    Text("Unspecified")
                        .tag(String?(nil))
                    ForEach(ethnicities, id : \.self) {
                        Text($0).tag(Optional($0))
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(8)
                .border(Color.gray.opacity(0.5))
                .tint(Color.black)
            }
            PatientInputField(label: "Gender") {
                Picker("", selection: $genderSelection) {
                    ForEach(genders, id : \.self) {
                        Text($0).tag(Optional($0))
                    }
                    Text("N/A")
                        .tag(String?(nil))
                }
                .pickerStyle(.segmented)
            }
            PatientInputField(label: "Location") {
                Picker("", selection: $selection) {
                    ForEach(locations, id : \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.menu)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(8)
                .border(Color.gray.opacity(0.5))
                .tint(Color.black)
            }
        }
    }
}

extension AddPatientView {
    private func createPatientFromTextfields() -> Patient {
        // TODO: Handle validation elsewhere
        let patient = Patient(id: Int(medicalID) ?? Int.random(in: 0..<Int.max), firstName: !firstName.isEmpty ? firstName : "Blank" , lastName: !lastName.isEmpty ? lastName : "Blank", birthdate: birthdate)
        return patient
    }
}

extension AddPatientView {
    struct PatientInputField<T>: View where T: View {
        var label: String
        var inputControlBuilder: () -> T
        
        var body: some View {
            HStack {
                Text(label)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                inputControlBuilder()
            }
        }
    }
}

struct AddPatientPreview: PreviewProvider {
    static var previews: some View {
        AddPatientView(cancelAction: {}, submitAction: {_ in })
            .previewLayout(.sizeThatFits)
    }
}
