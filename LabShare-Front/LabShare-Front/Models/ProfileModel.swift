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
    var name: String
    
    init(id: Int) {
        self.id = id
        self.name = ""
    }
}



struct ProfileModelEncodable: Codable {
    var title: String
    var name: String
}
