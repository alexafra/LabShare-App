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
    var dob: Date
    var occupation: String
    var employer: String
//    var imageName: String
    var owner: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case bio
        case dob
        case occupation
        case employer
//        case imageName = "image_name"
        case owner
    }
    
    init(id: Int, bio: String, dob: Date, occupation: String, employer: String, //imageName: String,
         owner: UserModel) {
        self.id = id
        self.bio = bio
        self.dob = dob
        self.occupation = occupation
        self.employer = employer
//        self.imageName = imageName
        self.owner = owner
    }
    
    init(ownerId: Int) {
        self.init()
        self.owner.id = ownerId
    }
    init() {
        let dateString = "01/01/1970"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var date: Date
        if let dateFromString = dateFormatter.date(from: dateString) {
            date = dateFromString
        } else {
            date = Date()
        }
        
        self.init(id: -1, bio: "", dob: date, occupation: "", employer: "", //imageName: "image1",
                  owner: UserModel())
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
