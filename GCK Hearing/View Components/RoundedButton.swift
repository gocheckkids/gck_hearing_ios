//
//  RoundedButton.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

struct RoundedButton: View {
    let title: String
    let color: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)

                .foregroundColor(.white)
                .padding(10)
                .background(color)
                .cornerRadius(5)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    RoundedButton(title: "Preview", color: .black, action: {})
        
}
