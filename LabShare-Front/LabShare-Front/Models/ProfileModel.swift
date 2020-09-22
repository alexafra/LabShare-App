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
    
    init(bio: String, dob: String, occupation: String, employer: String, owner: UserModel) {
        self.bio = bio
        self.dob = dob
        self.occupation = occupation
        self.employer = employer
        self.owner = owner
    }
    init() {
        self.init(bio: "", dob: "", occupation: "", employer: "", owner: UserModel())
    }
}



struct ProfileModelEncodable: Codable {
    var title: String
    var name: String
}
