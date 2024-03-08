//
//  ResultDetailsView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/8/24.
//

import SwiftUI

struct ResultDetailsView: View {
    @ObservedObject var resultDetailVM: ResultDetailsViewModel
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    Text(resultDetailVM.patient.fullName)
                    Text(resultDetailVM.patient.dob)
                    
                }
                Spacer()
                    .frame(height: 100)
                Text(resultDetailVM.results.hasRiskFactor ? "Risk Factor Identified" : "No Risk Factors")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .border(.black)
                resultSection
                Spacer()
                    .frame(height: 50)
                HStack(spacing: 50) {
                    RoundedButton(title: "Fax", color: .black) {
                        
                    }
                    RoundedButton(title: "Print", color: .black) {
                        
                    }
                }
                
            }
            .navigationTitle("Patient Results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    RoundedButton(title: "Done", color: .black, action: {})
                }
            }
        }
        
    }
}
extension ResultDetailsView {
    var resultSection: some View {
        VStack(alignment: .trailing) {
            HStack(spacing: 20) {
                Text("1000Hz")
                Image(systemName: "checkmark.square")
                Image(systemName: "checkmark.square")
            }
            HStack(spacing: 20) {
                Text("2000Hz")
                Image(systemName: "checkmark.square")
                Image(systemName: "checkmark.square")
            }
            HStack(spacing: 20) {
                Text("4000Hz")
                Image(systemName: "xmark.square")
                Image(systemName: "xmark.square")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .border(.black)
    }
}

struct ResultDetails_Preview: PreviewProvider {
    
    static var previews: some View {
        ResultDetailsView(resultDetailVM: ResultDetailsViewModel(patient: MockData.shared.mockPatient, results: MockData.shared.mockPatientResultDetails))
            .previewLayout(.sizeThatFits)
    }
}
