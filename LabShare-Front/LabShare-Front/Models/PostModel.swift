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
    
    init (id: Int, title: String, content: String, dateCreated: String, author: UserModel) {
        self.id = id
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
        self.author = author
    }
    
    init () {
        self.init (id: -1, title: "", content: "", dateCreated: "", author: UserModel())
    }
    
    
    init (title: String, content: String) {
        self.init(id: -1, title: title, content: content, dateCreated: "", author: UserModel())
    }
}



//I dont think this is right....
//struct PostEncodable: Codable {
//    var title: String
//    var content: String
//    var author: Int
//}
    
//    init(id: Int? = nil, title: String? = nil, content: String? = nil, date_created: String? = nil, author: Int? = nil) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.date_created = date_created
//        self.author = author
//    }

