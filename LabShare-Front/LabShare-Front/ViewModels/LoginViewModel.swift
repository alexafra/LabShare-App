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
    
    init () {
        userLogin = UserLoginModel(email: "", password: "")
    }
    
    func login(completion: @escaping (UserAuthenticationModel?) -> ()) {
        LoginWebService().login(user: userLogin, completion: completion)
    }
}

