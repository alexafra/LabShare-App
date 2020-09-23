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
    @Published var userRegister: UserRegisterModel
    @Published var repeatPassword: String
    
    @Published var attemptingRegistration: Bool
    @Published var registrationFailed: Bool
    
    @Published var passwordError: String
    @Published var emailError: String
    
    init () {
        userRegister = UserRegisterModel(email: "", password: "", firstName: "", lastName: "")
        repeatPassword = ""
        attemptingRegistration = false
        registrationFailed = false
        passwordError = ""
        emailError = ""
    }
    
    func register(completion: @escaping (UserAuthenticationModel?) -> ()) {
        if (!userRegister.password.isEmpty && userRegister.password == repeatPassword && !userRegister.email.isEmpty && !userRegister.firstName.isEmpty && !userRegister.lastName.isEmpty) {
            
            attemptingRegistration = true
            LoginWebService().register(user: userRegister, registerVM: self, completion: completion)
        }
    }
    var equalPasswords : Bool {
        return self.repeatPassword == self.userRegister.password
    }
    var isfirstNameEmpty: Bool {
        return self.userRegister.firstName == ""
    }
    var islastNameEmpty: Bool {
        return self.userRegister.lastName == ""
    }
}
