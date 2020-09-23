//
//  LoginViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var userLogin: UserLoginModel
    @Published var attemptingLogin: Bool
    @Published var loginFailed: Bool
    
    init () {
        userLogin = UserLoginModel(email: "", password: "")
        attemptingLogin = false
        loginFailed = false
    }
    
    func login(completion: @escaping (UserAuthenticationModel?) -> ()) {
        attemptingLogin = true
        if !self.userLogin.email.isEmpty && !self.userLogin.password.isEmpty {
            LoginWebService().login(user: userLogin, loginVM: self, completion: completion)
        } 
    }
    
//    func loginFailed() {
//        self.loginFailed = !self.loginFailed
//    }
}

