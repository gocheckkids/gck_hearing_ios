//
//  ScreeningViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/7/24.
//

import Foundation

class ScreeningViewModel: ObservableObject {
    
    enum ScreeningStates: String {
        case instruction = "Ready"
        case playing = "Playing"
        case completedStep = "Capture"
    }
    
    enum TestEar {
        case left
        case right
    }
    
    @Published var screeningState: ScreeningStates = .instruction
    
    var currentStep: Int = 0
    var frequencies = [100,200,300]
    var currentEar: TestEar = .left
    var instructionText = "When ready, press PLAY to send the tone"
    
    let patient: Patient
    
    init(patient: Patient) {
        self.patient = patient
    }
    
    
    func conductStep() async {
        // Play sound, then move to answering step
        print(screeningState)
        await playSound()
    }
    
    
    func playSound() async {
        await MainActor.run {
            screeningState = .playing
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
            self?.screeningState = .completedStep
        }
        
    }
    
    func answerQuestion(isCorrect: Bool)  {
        // Pass answer and current frequency to result handler and continue flow
        // <ResultHandler>.recordResult
        handleFlow()
    }
    
    func handleFlow() {
        // Left done, move to right
        if (currentEar == .left && currentStep == frequencies.count - 1) {
            currentEar = .right
            currentStep = 0
            screeningState = .instruction
        }
        // End of screening
        else if (currentEar == .right && currentStep == frequencies.count - 1) {
            // <ResultCoordinator.go(<ResultModel>)
            return
        }
        // else, continue screening
        else {
            currentStep += 1
            screeningState = .instruction
        }
        
        
    }
    
}
