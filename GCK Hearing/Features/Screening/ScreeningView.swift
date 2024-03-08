//
//  ScreeningView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/7/24.
//

import SwiftUI

struct ScreeningView: View {
    @ObservedObject var screeningVm: ScreeningViewModel
    
    var body: some View {
        
        NavigationView {
            VStack {
                Text("Patient: \(screeningVm.patient.fullName)")
                    .font(.title2)
                //                Text("Ear: \(screeningVm.currentEar == .left ? "Left" : "Right")")
                //                Text("Frequency: \(screeningVm.frequencies[screeningVm.currentStep])")
                
                switch screeningVm.screeningState {
                case .instruction:
                    instructionView
                case .playing:
                    playingSoundView
                case.completedStep:
                    answeringView
                }
                
                
            }
            .navigationTitle("Step \(screeningVm.currentStep) of 6 - \(screeningVm.screeningState.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Pause", color: .black, action: {
                        // Pause Popup menu
                    })
                }
            }
        }
        
        
    }
}
extension ScreeningView {
    var instructionView: some View {
        VStack(spacing: 30) {
            
            HStack(alignment: .top) {
                Image(systemName: "headphones")
                    .resizable()
                .frame(width: 100, height: 120)
            }
            .frame(maxWidth: .infinity)
            
            Text(screeningVm.instructionText)
            
            RoundedButton(title: "Play", color: .black) {
                Task {
                    await screeningVm.conductStep()
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    var playingSoundView: some View {
        VStack {
            Image(systemName: "ear.and.waveform")
                .resizable()
                .frame(width: 100, height: 120)
            Text("Playing tone:")
                .font(.title2)
            Text("\(screeningVm.frequencies[screeningVm.currentStep])hz")
                .font(.title)
            ProgressView()
                .tint(.blue)
                .progressViewStyle(.circular)
                .controlSize(.large)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    var answeringView: some View {
        VStack {
            Text("Did \(screeningVm.patient.firstName) hear the tone?")

            HStack {
                RoundedButton(title: "No", color: .black) {
                    screeningVm.answerQuestion(isCorrect: false)
                }
                Spacer()
                    .frame(width: 100)
                RoundedButton(title: "Yes", color: .black) {
                    screeningVm.answerQuestion(isCorrect: true)
                }
            }
        }
        .frame(maxHeight: .infinity, alignment: .center)
        
    }
}

struct ScreeningView_Preview: PreviewProvider {
    static var previews: some View {
        ScreeningView(screeningVm: ScreeningViewModel(patient: MockData.shared.mockPatient))
            .previewLayout(.sizeThatFits)
    }
}
