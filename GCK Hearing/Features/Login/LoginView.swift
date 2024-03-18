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
    
    
    @ObservedObject var loginVM: LoginViewModel
    
    var body: some View {
       
        VStack(spacing: 20) {
                Image("gck_stacked_logo") // Assuming "header_image" is in your assets
                    .resizable()
                    .frame(width: 260, height: 130)
                    .scaledToFit()
                    .padding(50)
                
            Group {
                TextField("Email", text: $loginVM.emailText)
                
                Divider()
                    .frame(height: 1)
                    .background(.cyan)
                
                SecureField("Password", text: $loginVM.passwordText)
                Divider()
                    .frame(height: 1)
                    .background(.cyan)
            }
            .padding(.horizontal, 25)
            
            Spacer()
                .frame(height: 30)
               
            Group {
                Button {
                    isLoggedIn = true
                    loginVM.loginAction?(isLoggedIn, loginVM.isMultilocationEnabled)
                } label: {
                    Text("Login")
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(Color.blueTheme.accentDark)
                        .cornerRadius(5)
                }
                Button {
                    
                } label: {
                    Text("Forgot Password")
                        .foregroundColor(Color.deepBlueTheme.accent)
                }
                Button {
                    
                } label: {
                    Text("About")
                        .foregroundColor(Color.deepBlueTheme.accent)
                }
            }
            Spacer()
            Toggle("Enable Multilocation", isOn: $loginVM.isMultilocationEnabled)
                .foregroundColor(Color.blueTheme.accentDark)
                .padding()
            
            }
        .frame(maxHeight: .infinity, alignment: .top)
            .padding()
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(loginVM: LoginViewModel())
    }
}
