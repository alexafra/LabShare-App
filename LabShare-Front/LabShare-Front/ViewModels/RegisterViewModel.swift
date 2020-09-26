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

class RegisterViewModel: ObservableObject {
    @Published var userRegisterModel: UserRegisterModel
    @Published var repeatPassword: String
    
    @Published var attemptingRegistrationAndLogin: Bool
    @Published var registrationFailed: Bool
    
    @Published var passwordError: String
    @Published var emailError: String
    @Published var loginFailed: Bool
    @Published var loginSuccessful: Bool
    
    var userAuthVM: UserAuthenticationViewModel
    
    init (userAuthVM: UserAuthenticationViewModel) {
        self.userRegisterModel = UserRegisterModel(email: "", password: "", firstName: "", lastName: "")
        self.repeatPassword = ""
        self.attemptingRegistrationAndLogin = false
        self.registrationFailed = false
        self.passwordError = ""
        self.emailError = ""
        self.userAuthVM = userAuthVM
        self.loginFailed = false
        self.loginSuccessful = false
    }
    
    func register() {
        
        if (!userRegisterModel.password.isEmpty && userRegisterModel.password == repeatPassword && !userRegisterModel.email.isEmpty && !userRegisterModel.firstName.isEmpty && !userRegisterModel.lastName.isEmpty) {
            
            self.attemptingRegistrationAndLogin = true
            LoginRegisterWebService().register(userRegisterModel: self.userRegisterModel,
               completionFailure: { (registrationError) in
                    self.attemptingRegistrationAndLogin = false
                    self.registrationFailed = true
                    self.repeatPassword = ""
                    self.userRegisterModel.password = ""
                    if let registrationError = registrationError {
                        if let emailError = registrationError.email {
                            self.emailError = emailError[0]
                        }
                        if let passwordError = registrationError.password {
                            self.passwordError = passwordError[0]
                        }

                    }
                        
                },
               completionSuccessful: { (userModel, userLoginModel) in
                    self.registrationFailed = false
                    if let userLoginModel = userLoginModel {
                        LoginRegisterWebService().login(user: userLoginModel,
                            completionFailure: { () -> Void in
                                self.attemptingRegistrationAndLogin = false
                                self.loginFailed = true
                            },
                            completionSuccessful: { (userAuthModel: UserAuthenticationModel?) in
                                self.attemptingRegistrationAndLogin = false
                                if let userSettings = userAuthModel {
                                    self.loginFailed = false
                                    self.loginSuccessful = true
                                    self.userAuthVM.userAuth = userSettings
                                    self.userAuthVM.userAuth.isLoggedIn = true
                                } else {
                                    self.loginFailed = true
                                }
                            }
                        )
                    }
                    
                }
            )

        }
    }
    
    func register2(completion: @escaping (UserAuthenticationModel?) -> ()) {
        if (!userRegisterModel.password.isEmpty && userRegisterModel.password == repeatPassword && !userRegisterModel.email.isEmpty && !userRegisterModel.firstName.isEmpty && !userRegisterModel.lastName.isEmpty) {
            
            attemptingRegistrationAndLogin = true
            LoginWebService().register(user: userRegisterModel, registerVM: self, completion: completion)
        }
    }
//    var equalPasswords : Bool {
//        return self.repeatPassword == self.userRegisterModel.password
//    }
//    var isfirstNameEmpty: Bool {
//        return self.userRegisterModel.firstName == ""
//    }
//    var islastNameEmpty: Bool {
//        return self.userRegisterModel.lastName == ""
//    }
}
