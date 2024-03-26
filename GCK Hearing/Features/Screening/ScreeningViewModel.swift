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
    @Published var isPlayingSoundNow: Bool = false
    
    @Published var selectedScreeningProtocol: String = ""
    @Published var screeningProtocols: [String] = [""]
    
    var screeningCompleteAction: ((Patient, ResultDetails) -> ())? = {_,_ in}
    
    var pauseTappedAction: (() ->())? = {}
    
    var currentStep: Int = 1
    var frequencies = [1000, 2000]
    let stepCount: Int
    var currentEar: TestEar = .left
    var currentFrequencyIndex = 0
    
    var instructionText = """
    1. Ensure a protocol is selected.
    
    2. When ready, press PLAY to send the tone
    """
    
    let patient: Patient
    
    init(patient: Patient) {
        self.patient = patient
        stepCount = frequencies.count * 2
    }
    
    
    func conductStep() async {
        // Play sound, then move to answering step
        print(screeningState)
        await playSound()
    }
    
    
    func playSound() async {
        screeningState = .playing
        let rand = Int.random(in: 0...2)
        // after a random # of seconds (1-4s), play the sound for 1 second, then complete
        print("Waiting to play sound")
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(rand)) { [weak self] in
                self?.isPlayingSoundNow = true
            print("Sound ON")
            // actual playing of the sound here, for 1 second, then turn off
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) { [weak self] in
                print("Sound OFF")
                self?.isPlayingSoundNow = false
                self?.screeningState = .completedStep
            }
        }
    }
    
    func answerQuestion(isCorrect: Bool)  {
        // Pass answer and current frequency to result handler and continue flow
        // <ResultHandler>.recordResult
        handleFlow()
    }
    
    func handleFlow() {
        // Right done? Test complete
        if (currentEar == .right && currentStep == (frequencies.count*2)) {
            let details = ResultDetails(date: "02-10-2024")
            screeningCompleteAction?(patient, details)
            return
        }
        // Or, if done on left, go to right
        else if (currentEar == .left && currentStep == frequencies.count) {
            currentEar = .right
            currentStep += 1
            currentFrequencyIndex = 0
            screeningState = .instruction
        }
        // End of screening
//        else if (currentEar == .right && currentStep == frequencies.count - 1) {
//            // <ResultCoordinator.go(<ResultModel>)
//            let details = ResultDetails(date: "02-10-2024")
//            screeningCompleteAction?(patient, details)
//            return
//        }
        // else, continue screening
        else {
            currentFrequencyIndex += 1
            currentStep += 1
            screeningState = .instruction
        }
    }
    
}
