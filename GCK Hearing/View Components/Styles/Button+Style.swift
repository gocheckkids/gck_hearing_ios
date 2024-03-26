//
//  Button+Style.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/26/24.
//

import Foundation
import SwiftUI

struct MainActionButtonStyle: ButtonStyle {
    var backgroundColor: Color? = .black
    var foregroundColor: Color? = .white
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.subheadline.bold())
            .textCase(.uppercase)
            .padding(12)
            .frame(maxWidth: UIScreen.main.bounds.width/2)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(6)
    }
}
