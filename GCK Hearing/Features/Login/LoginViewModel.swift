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
    @Published var isMultilocationEnabled = false
    
    var loginAction: ((Bool, Bool) -> Void)? = {_,_ in}
 
    
//    func login() async {
//        await MainActor.run {
//            isLoggedIn = true
//        }
//        loginAction?(isLoggedIn)
//    }
}
