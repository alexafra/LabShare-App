//
//  Comment.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 3/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct CommentModel: Hashable, Codable, Identifiable {
    var id: Int
    var dateCreated: Date
    var postId: Int
    var content: String
    var author: UserModel
    
    enum CodingKeys: String, CodingKey
    {
        case id
        case dateCreated = "date_created"
        case postId = "post"
        case content
        case author
    }

    init (id: Int, dateCreated: Date, postId: Int, content: String, author: UserModel) {
        self.id = id
        self.dateCreated = dateCreated
        self.postId = postId
        self.content = content
        self.author = author
    }
    
    init() {
        self.init(id: -1, dateCreated: Date(), postId: -1, content: "", author: UserModel())
    }
    
    init (content: String, postId: Int, authorId: Int) {
        self.init()
        self.content = content
        self.postId = postId
        self.author.id = authorId
    }
    
}
