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
                    
                    .padding(20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                HStack {
                    Text("Protocol: ")
                        .font(.title3)

                    Picker("Protocols", selection: $screeningVm.selectedScreeningProtocol) {
                        ForEach(screeningVm.screeningProtocols, id : \.self) {
                            Text($0)
                        }
                    }
                        .pickerStyle(.menu)
                        .frame(maxWidth: .infinity)
                        .padding(8)
                        .border(Color.gray.opacity(0.5))
                        .tint(Color.black)
                        .onTapGesture {
                            Task {
                                print("LOADING")
                                await screeningVm.loadProtocols()
                            }
                        }
                        .disabled((screeningVm.currentStep == 1 && screeningVm.screeningState == .instruction) ? false : true)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
                
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
            .navigationTitle("Step \(screeningVm.currentStep) of \(screeningVm.maxStepCount) - \(screeningVm.screeningState.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Pause", color: Color.deepBlueTheme.background) {
                        screeningVm.pauseTappedAction?()
                    }
                }
            }
        }
        .task {
            print("Loading all protocols NOW")
            await screeningVm.loadProtocols()
        }
    }
}
extension ScreeningView {
    var instructionView: some View {
        VStack(spacing: 30) {
            ZStack {
                Image(systemName: "headphones")
                    .font(.system(size: 75))
                    .imageScale(.large)
                Image(systemName: screeningVm.currentEar == .left ? "l.circle.fill" : "r.circle.fill")
                    .font(.title)
                    .imageScale(.large)
                    .foregroundColor(screeningVm.currentEar == .left ? .blue : .red)
                    .offset(CGSize(width: screeningVm.currentEar == .left ? -80: 80, height: -20))
            }
            
            Text(screeningVm.instructionText)
                .multilineTextAlignment(.center)
                .font(.headline)
            
            Spacer()
                .frame(height: UIScreen.main.bounds.height / 10)
            
            Button("Play") {
                Task {
                    await screeningVm.conductStep()
                }
            }
            .buttonStyle(MainActionButtonStyle(
                backgroundColor: Color.deepBlueTheme.background,
                foregroundColor: Color.white
            ))
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
