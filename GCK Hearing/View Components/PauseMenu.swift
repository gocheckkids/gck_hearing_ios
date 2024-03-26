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

extension PauseMenu {
    struct PauseMenuOptionButton: View {
        let title: String
        let color: Color
        let action: () -> Void
        var body: some View {
            Button(action: action, label: {
                Text(title)
            })
            .foregroundStyle(.white)
            .font(.subheadline)
            .textCase(.uppercase)
            .padding(10)
            .frame(maxWidth: UIScreen.main.bounds.width / 2)
            .background(color)
            .cornerRadius(6)
        }
    }
    
    struct PauseMenuOptionStyle: ButtonStyle {
        func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .font(.subheadline.bold())
                .textCase(.uppercase)
                .padding(12)
                .frame(maxWidth: UIScreen.main.bounds.width/2)
        }
    }
}

#Preview {
    PauseMenu()
//        .frame(maxHeight: .infinity, alignment: .bottom)
        .frame(height: UIScreen.main.bounds.height / 2)
        .frame(maxWidth: .infinity)
        .border(.green)
}

/** Buttons:
 retest
 back to test
 back to home
 */
