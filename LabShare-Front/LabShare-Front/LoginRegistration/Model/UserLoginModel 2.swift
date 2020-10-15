//
//  UserLoginModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 4/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//
import Foundation

struct UserLoginModel: Codable {
    var email: String
    var password: String
    
    init (email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    init () {
        self.init(email: "", password: "")
    }
    
    init (userRegisterModel: UserRegisterModel) {
        self.init (email: userRegisterModel.email, password: userRegisterModel.password)
    }
}
