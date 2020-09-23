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
    @Published var isRegistering: Bool
    @Published var hasRegistered: Bool
    
    init () {
        userRegister = UserRegisterModel(email: "", password: "", firstName: "", lastName: "")
        isRegistering = false
        hasRegistered = false
    }
    
    func register(completion: @escaping (UserRegisterModel?, Bool) -> ()) {
        LoginWebService().register(user: userRegister, completion: completion)
    }
}

