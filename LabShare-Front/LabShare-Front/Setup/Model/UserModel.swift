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
    var imageName: String
    var isActive: Bool
    var isStaff: Bool
    
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
        case imageName = "image_name"
        case isStaff = "is_staff"
        case isActive = "is_active"
    }
    
    init(id: Int, email: String, firstName: String, lastName: String, imageName: String, isStaff: Bool, isActive: Bool) {
        self.id = id
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.imageName = imageName
        self.isStaff = isStaff
        self.isActive = isActive
    }
    
    init() {
        self.init(id: -1, email: "", firstName: "", lastName: "", imageName: "image1", isStaff: false, isActive: true)
    }
}



struct UserAuthenticationModel: Codable, Identifiable {
    var id: Int = -1
    var token: String
    var isLoggedIn: Bool = false
    var isStaff: Bool
    var isActive: Bool
    
    private enum CodingKeys: String, CodingKey {
        case token
        case id
        case isStaff = "is_staff"
        case isActive = "is_active"
    }
}

