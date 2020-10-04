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
    var userAuthVM: UserAuthenticationViewModel
    
    init (userAuthVM: UserAuthenticationViewModel) {
        self.userLogin = UserLoginModel(email: "", password: "")
        self.attemptingLogin = false
        self.loginFailed = false
        self.userAuthVM = userAuthVM
    }
    
    func login() {
        if !self.userLogin.email.isEmpty && !self.userLogin.password.isEmpty {
            //self.userLogin once in the function parameter is a copy that cant be changed by the view
            self.attemptingLogin = true
            LoginRegisterWebService().login(user: self.userLogin,
                completionFailure: { () -> Void in
                    self.attemptingLogin = false
                    self.loginFailed = true
                    self.userLogin.password = ""
                },
                completionSuccessful: { (userAuthModel: UserAuthenticationModel?) in
                    self.attemptingLogin = false
                    if let userSettings = userAuthModel {
                        self.loginFailed = false
                        self.userAuthVM.userAuth = userSettings
                        self.userAuthVM.userAuth.isLoggedIn = true
                    } else {
                        self.loginFailed = true
                    }
                }
            )
        }
    }
}

