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
            VStack() {
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
            .frame(maxWidth: .infinity, alignment: .center)
            .navigationTitle("Step \(screeningVm.currentStep) of \(screeningVm.stepCount) - \(screeningVm.screeningState.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Pause", color: Color.blueTheme.accentDark) {
                        screeningVm.menuExitAction?()
                    }
                }
            }
        }
    }
}
extension ScreeningView {
    var instructionView: some View {
        VStack(spacing: 30) {
            ZStack(alignment: screeningVm.currentEar == .left ? .topLeading : .topTrailing) {
                Image(systemName: "headphones")
                    .font(.system(size: 75))
                    .imageScale(.large)
//                    .resizable()
//                .frame(width: 100, height: 120)
                Image(systemName: screeningVm.currentEar == .left ? "l.circle.fill" : "r.circle.fill")
                    .font(.title)
                    .imageScale(.large)
                    .foregroundColor(screeningVm.currentEar == .left ? .blue : .red)
                    .offset(CGSize(width: screeningVm.currentEar == .left ? -40: 40, height: 0))
            }
//            .frame(maxWidth: .infinity)
            
            Text(screeningVm.instructionText)
            
            RoundedButton(title: "Play", color: Color.theme.accent) {
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
                .foregroundColor(screeningVm.currentEar == .left ? .blue : .red)
            Text("Playing tone:")
                .font(.title2)
            Text("\(screeningVm.frequencies[screeningVm.currentFrequencyIndex])hz")
                .font(.title)
            Image(systemName: screeningVm.isPlayingSoundNow ? "speaker.wave.3.fill" : "speaker.wave.1")
//                .resizable()
//                .frame(width: 80, height: 50)
//                .resizable()
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundColor(screeningVm.isPlayingSoundNow ? Color.theme.accent: Color.deepBlueTheme.accent )
                .padding()
//                .tint(Color.theme.accent)
//                .progressViewStyle(.circular)
//                .controlSize(.large)
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
    
    var answeringView: some View {
        VStack(spacing: 30) {
            Image(systemName: "person.fill.questionmark")
                .font(.system(size: 75))
                .imageScale(.large)
                .foregroundColor(screeningVm.currentEar == .left ? .blue : .red)
                .symbolRenderingMode(.hierarchical)
                
            Text("Did the patient hear the tone?")
            Spacer()
                .frame(height: 50)
            HStack {
                RoundedButton(title: "No", color: Color.red) {
                    screeningVm.answerQuestion(isCorrect: false)
                }
                .font(.title2)
                .frame(width: 100)
                .padding()
                .background(.red)
                .cornerRadius(8)
                Spacer()
                    .frame(width: 100)
                RoundedButton(title: "Yes", color: Color.theme.accent) {
                    screeningVm.answerQuestion(isCorrect: true)
                }
                .font(.title2)
                .frame(width: 100)
                .padding()
                .background(Color.theme.accent)
                .cornerRadius(8)
            }
//            .padding()
        }
        .frame(maxHeight: .infinity, alignment: .center)
    }
}

struct ScreeningView_Preview: PreviewProvider {
    static var vm = ScreeningViewModel(patient: MockData.shared.mockPatient)
    
    static var previews: some View {
        let screenView = ScreeningView(screeningVm: vm)
        Group {
            screenView
            screenView.instructionView
            screenView.playingSoundView
            screenView.answeringView
        }
        .previewLayout(.sizeThatFits)
    }
       
    
}
