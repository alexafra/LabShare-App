//
//  Posts.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct Posts: Codable {
    var posts: [Post]
}

struct Post: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var date_created: String
    var author: Int
}
