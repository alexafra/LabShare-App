//
//  UserSettingsViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class UserAuthenticationViewModel: ObservableObject {
    @Published var userAuth: UserAuthenticationModel
    
    init(id: Int, token: String, isLoggedIn: Bool) {
        userAuth = UserAuthenticationModel(id: -1, token: "", isLoggedIn: false)
    }
    init() {
        userAuth = UserAuthenticationModel(id: -1, token: "", isLoggedIn: false)
    }
    
}

