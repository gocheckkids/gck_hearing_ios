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
                PatientInfoSectionView(patient: resultDetailVM.patient)
               
                Spacer()
                    .frame(height: 100)
                Group {
                    Text(resultDetailVM.results.hasRiskFactor ? "Risk Factor Identified" : "No Risk Factors")
                        .font(.headline)
                        .foregroundColor(resultDetailVM.results.hasRiskFactor ? .red : Color.theme.accent)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .border(.black)
                    resultSection
                }
                
                Spacer()
                    .frame(height: 50)
                HStack(spacing: 50) {
                    RoundedButton(title: "Fax", color: Color.deepBlueTheme.accent) {
                        
                    }
                    RoundedButton(title: "Print", color: Color.deepBlueTheme.accent) {
                        
                    }
                }
            }
            .padding(.horizontal, 25)
            .navigationTitle("Patient Results")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    RoundedButton(title: "Done", color: Color.blueTheme.accentDark) {
                        resultDetailVM.doneAction?()
                    }
                }
            }
        }
    }
}
extension ResultDetailsView {
    var resultSection: some View {
        VStack(alignment: .trailing) {
//            Text("Frequencies")
                
            HStack(spacing: 20) {
                Text("1000Hz")
                Image(systemName: "checkmark.square")
                    .foregroundColor(.theme.background)
                Image(systemName: "checkmark.square")
                    .foregroundColor(.theme.background)
                Spacer()
                Image(systemName: "square")
                Image(systemName: "square")
            }
            HStack(spacing: 20) {
                Text("2000Hz")
                Image(systemName: "checkmark.square")
                    .foregroundColor(.theme.background)
                Image(systemName: "checkmark.square")
                    .foregroundColor(.theme.background)
                Spacer()
                Image(systemName: "square")
                Image(systemName: "square")
            }
            HStack(spacing: 20) {
                Text("4000Hz")
                Image(systemName: "xmark.square")
                    .foregroundColor(.red)
                Image(systemName: "xmark.square")
                    .foregroundColor(.red)
                Spacer()
                Image(systemName: "square")
                Image(systemName: "square")
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
