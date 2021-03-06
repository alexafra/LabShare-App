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
    var dateCreated: Date
    var category: CategoryEnum
    var author: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case title
        case content
        case category
        case dateCreated = "date_created"
        case author
    }
    
//    init (id: Int, title: String, content: String, dateCreated: Date, author: UserModel) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.dateCreated = dateCreated
//        self.author = author
//        self.category = CategoryEnum.None
//    }
    init (id: Int, title: String, content: String, dateCreated: Date, category: CategoryEnum, author: UserModel) {
        self.id = id
        self.title = title
        self.content = content
        self.dateCreated = dateCreated
        self.author = author
        self.category = category
    }
    
    init () {
        self.init (id: -1, title: "", content: "", dateCreated: Date(), category: CategoryEnum.None, author: UserModel())
    }
    
    init (userId: Int, postId: Int) {
        self.init()
        self.id = postId
        self.author.id = userId
    }
    
    init (title: String, content: String, category: CategoryEnum, authorId: Int) {
        self.init(id: -1, title: title, content: content, dateCreated: Date(), category: category, author: UserModel())
        self.author.id = authorId
    }
}

enum CategoryEnum: String, Codable {
    case None = ""
    case Reagents = "Reagents"
    case Equipment = "Equipment"
    case Expertise = "Expertise"
    
}

//struct PostEncodableModel: Codable {
//    var title: String
//    var content: String
//    var author: Int
//}
//
//    init(id: Int? = nil, title: String? = nil, content: String? = nil, date_created: String? = nil, author: Int? = nil) {
//        self.id = id
//        self.title = title
//        self.content = content
//        self.date_created = date_created
//        self.author = author
//    }

