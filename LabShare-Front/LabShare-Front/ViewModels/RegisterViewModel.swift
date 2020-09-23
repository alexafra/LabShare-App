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
    
    @Published var hasAttemptedRegister: Bool
    @Published var isReattempting: Bool
    @Published var hasRegistered: Bool
    
    @Published var passwordError: String
    @Published var emailError: String
    
    @Published var isRegistering: Bool
//    @Published var
    
    init () {
        userRegister = UserRegisterModel(email: "", password: "", firstName: "", lastName: "")
        isRegistering = false
        hasRegistered = false
        repeatPassword = ""
        hasAttemptedRegister = false
        passwordError = ""
        emailError = ""
        isReattempting = false
    }
    
    func register(completion: @escaping (UserRegisterModel?, Bool) -> ()) {
        if (userRegister.password == repeatPassword && userRegister.email != "" && userRegister.firstName != "" && userRegister.lastName != "") {
            isRegistering = true
            hasRegistered = false
            LoginWebService().register(user: userRegister, completion: completion)
        } else {
            
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
