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
                RoundedButton(title: "Login Button", color: .cyan) {
                    Task {
                        await loginVM.login()
                    }
                }
                Button {
                    
                } label: {
                    Text("Forgot Password")
                }
                Button {
                    
                } label: {
                    Text("About")
                }
            }
            
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
