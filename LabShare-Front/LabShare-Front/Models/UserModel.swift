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
    var password: String
}

struct UserLoginModel: Codable {
    var email: String
    var password: String
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

