//
//  RegistrationModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

//What we send
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

//Error We receive
struct RegistrationErrorResponse: Codable {
    var email: [String]?
    var password: [String]?
}

//Valid Response we receive
enum RegistrationResponse: Decodable {
    case success(UserModel)
    case failure(RegistrationErrorResponse)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        do {
            let userModel = try container.decode(UserModel.self)
            self = .success(userModel) //Value
        } catch {
            let error = try container.decode(RegistrationErrorResponse.self)
            self = .failure(error) //value
        }
    }
}
