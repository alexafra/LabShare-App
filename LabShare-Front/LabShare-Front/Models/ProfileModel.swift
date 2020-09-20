//
//  Users.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct ProfileModel: Hashable, Codable, Identifiable {
    var id: Int
    var email: String
    var firstName: String
    var lastName: String
    var occupation: String
    var employer: String
    var dateOfBirth: String
    var bio: String
    
    init(id: Int) {
        self.id = id
        self.email
    }
}



struct ProfileModelEncodable: Codable {
    var title: String
    var name: String
}
