//
//  Users.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct Users: Codable {
    var posts: [User]
}

struct User: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
}

struct UserEncodable: Codable {
    var title: String
    var name: String
}
