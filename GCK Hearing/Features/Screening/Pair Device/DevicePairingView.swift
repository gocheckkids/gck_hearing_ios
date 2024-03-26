//
//  DevicePairingView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/26/24.
//

import SwiftUI

struct DevicePairingView: View {

    var pairTappedAction: (() -> ())?
    var backAction: (() -> ())?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                ZStack {
                    Image(systemName: "headphones")
                        .font(.system(size: 75))
                        .imageScale(.large)
                    Image(systemName: "qrcode.viewfinder")
                        .font(.title)
                        .imageScale(.large)
                }
                
                Text("""
                     Scan the QR code on the headset
                     
                     This will pair the devices
                     """)
                    .multilineTextAlignment(.center)
                    .font(.headline)
                
                Spacer()
                    .frame(height: UIScreen.main.bounds.height / 10)
                
                Button("Scan & Pair") {
                    pairTappedAction?()
                }
                .buttonStyle(MainActionButtonStyle(
                    backgroundColor: Color.deepBlueTheme.background,
                    foregroundColor: Color.white
                ))
            }
            .navigationTitle("Headset Pairing")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    RoundedButton(title: "Back", color: Color.deepBlueTheme.background) {
                        backAction?()
                    }
                }
            }
        }
    }
}

#Preview {
    DevicePairingView()
}
