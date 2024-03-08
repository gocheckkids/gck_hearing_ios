//
//  PatientDetailView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/7/24.
//

import SwiftUI

struct PatientDetailView: View {

    @ObservedObject var detailVm: PatientDetailViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                patientInfoSection
                switch detailVm.loadState {
                case .loading:
                    PatientListLoadingView()
                case .success:
                    visitSection
                case .failed:
                    PatientListErrorView()
                }
//                visitSection
                RoundedButton(title: "Conduct Pure Tone Screening", color: .black) {
                    // Go to screening page
                }
            }
            .frame(alignment: .top)
            .navigationTitle("Patient Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Back", color: .black, action: {})
                }
            }
        }
        .task {
            await detailVm.getLatestScreenings()
        }
//        .onAppear {
//            Task {
//                // Load top 3 past results
//                await detailVm.getLatestScreenings()
//            }
//        }
        
    }
}

extension PatientDetailView {
    private var patientInfoSection: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("First Name: \(detailVm.patient.firstName)")
            Text("Last Name: \(detailVm.patient.lastName)")
            Text("Date Of Birth: \(detailVm.patient.dob)")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .border(.black)
    }
    
    private var visitSection: some View {
        // Show last 3 visits with option to show more, may require own ViewModel
        VStack {
            Text("Past Results")
                .font(.title3)
                .bold()
            
            ForEach(detailVm.recentResults) { summary in
                HStack {
                    RoundedButton(title: summary.date, color: .black) {
                        
                    }
                    Text(summary.riskFactorSummary)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .border(.black)
                }
            }
     
            RoundedButton(title: "View More", color: .black) {
                // change Binded state, new view etc.
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .border(.black)
    }
}

struct PatientDetailPreview: PreviewProvider {

     static var previews: some View {
         PatientDetailView(detailVm: PatientDetailViewModel(patient: MockData.shared.mockPatient, loader: LocalPatientVisitsLoader()))
            .previewLayout(.sizeThatFits)
    }
}
