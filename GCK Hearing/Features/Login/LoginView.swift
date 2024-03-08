//
//  ContentView.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/5/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false

    var body: some View {
       
            VStack {
                Image("header_image") // Assuming "header_image" is in your assets
                    .resizable()
                    .frame(height: 200)
                    .scaledToFit()

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding(.horizontal, 50)

                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(5.0)
                    .padding([.horizontal, .bottom], 50)

                Button(action: {
                    // Perform login logic here, for simplicity, I'm just setting isLoggedIn to true
                    self.isLoggedIn = true
                }) {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10.0)
                }
            }
            .padding()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

