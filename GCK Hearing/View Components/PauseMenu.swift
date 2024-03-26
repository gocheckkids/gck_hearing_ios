//
//  PauseMenu.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/24/24.
//

import SwiftUI

struct PauseMenu: View {
    var retest: (()->())?
    var exit: (()->())?
    var resume: (()->())?
    var body: some View {
        VStack(spacing: 25) {
            Button("Retest", action: retest ?? {})
                .buttonStyle(MainActionButtonStyle(
                    backgroundColor: Color.deepBlueTheme.background,
                    foregroundColor: Color.white
                ))
            Button("Back to test", action: resume ?? {})
                .buttonStyle(MainActionButtonStyle(
                    backgroundColor: Color.deepBlueTheme.accent.opacity(0.5),
                    foregroundColor: Color.black
                ))
            Button("Back to home", action: exit ?? {})
                .buttonStyle(MainActionButtonStyle(
                    backgroundColor: Color.deepBlueTheme.accent.opacity(0.5),
                    foregroundColor: Color.black
                ))
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .offset(CGSize(width: 0.0, height: -50.0))
    }
}

#Preview {
    PauseMenu()
        .frame(height: UIScreen.main.bounds.height / 2)
        .frame(maxWidth: .infinity)
        .border(.green)
}
