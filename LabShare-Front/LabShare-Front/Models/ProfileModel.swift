//
//  Users.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct ProfileModel: Hashable, Codable {
    var bio: String
    var dob: String
    var occupation: String
    var employer: String
    var owner: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case bio
        case dob
        case occupation
        case employer
        case owner
    }
}



struct ProfileModelEncodable: Codable {
    var title: String
    var name: String
}
