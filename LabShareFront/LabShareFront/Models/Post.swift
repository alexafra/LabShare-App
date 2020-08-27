//
//  Posts.swift
//  LabShareFront
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

struct Post: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var postText: String
}
