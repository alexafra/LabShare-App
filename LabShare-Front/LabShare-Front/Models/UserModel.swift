//
//  UserModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct UserModel: Hashable, Codable, Identifiable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    
//    "id": 8,
//    "email": "graycumming@gmail.com",
//    "profile": 2,
//    "first_name": "Gray",
//    "last_name": "Cumming"
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
    init(id: Int, email: String, firstName: String, lastName: String) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
    }
    
    init() {
        self.init(id: -1, email: "", firstName: "", lastName: "")
    }
}

struct UserLoginModel: Codable {
    var email: String
    var password: String
}

struct UserRegisterModel: Codable {
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    
    enum CodingKeys: String, CodingKey
    {
        case email
        case password
        case firstName = "first_name"
        case lastName = "last_name"
    }
    
}

struct UserAuthenticationModel: Codable, Identifiable {
    var id: Int = -1
    var token: String
    var isLoggedIn: Bool = false
    
    private enum CodingKeys: String, CodingKey {
        case token
        case id
    }
}

