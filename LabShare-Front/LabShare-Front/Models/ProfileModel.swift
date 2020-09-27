//
//  Users.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct ProfileModel: Codable, Identifiable, Hashable {
    var id: Int
    var bio: String
    var dob: String
    var occupation: String
    var employer: String
    var owner: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case bio
        case dob
        case occupation
        case employer
        case owner
    }
    
    init(id: Int, bio: String, dob: String, occupation: String, employer: String, owner: UserModel) {
        self.id = id
        self.bio = bio
        self.dob = dob
        self.occupation = occupation
        self.employer = employer
        self.owner = owner
    }
    
    init(ownerId: Int) {
        self.init()
        self.owner.id = ownerId
    }
    init() {
        self.init(id: -1, bio: "", dob: "", occupation: "", employer: "", owner: UserModel())
    }
    
//    init(profile: ProfileModel) {
//        self.id = profile.id
//        self.bio = profile.bio
//        self.dob = profile.dob
//        self.occupation = profile.occupation
//        self.employer = profile.employer
//        self.owner = profile.owner
//    }
}



struct ProfileModelEncodable: Codable {
    var title: String
    var name: String
}
