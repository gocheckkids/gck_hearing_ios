//
//  LoginViewModel.swift
//  GCK Hearing
//
//  Created by Sharrar Wasit on 3/11/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isLoggedIn = false
    
 
    
    func login() async {
        await MainActor.run {
            isLoggedIn = true
        }
    }
}
