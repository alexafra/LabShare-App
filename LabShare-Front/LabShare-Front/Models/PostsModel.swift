//
//  Posts.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

//Changge to let
struct PostModel: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var content: String
    var dateCreated: String
    var author: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case content
        case dateCreated = "date_created"
        case author
    }
}



//I dont think this is right....
struct PostEncodable: Codable {
    var title: String
    var content: String
    var author: Int
}
    
//    init(id: Int? = nil, title: String? = nil, content: String? = nil, date_created: String? = nil, author: Int? = nil) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.date_created = date_created
//        self.author = author
//    }

