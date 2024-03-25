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
                .background(Color.deepBlueTheme.background)
                .buttonStyle(PauseMenuOptionStyle())
                .foregroundColor(.white)
                .cornerRadius(6)
            Button("Back to test", action: resume ?? {})
                .background(Color.deepBlueTheme.accent.opacity(0.5))
                .buttonStyle(PauseMenuOptionStyle())
                .foregroundColor(.black)
                .cornerRadius(6)
            Button("Back to home", action: exit ?? {})
                .background(Color.deepBlueTheme.accent.opacity(0.5))
                .buttonStyle(PauseMenuOptionStyle())
                .foregroundColor(.black)
                .cornerRadius(6)
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
