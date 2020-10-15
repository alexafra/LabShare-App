//
//  ResetPasswordModel.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 11/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//
import Foundation

struct ResetPasswordModel: Codable {
    var email: String
    
    init (email: String) {
        self.email = email    }
    
    init () {
        self.init(email: "")
    }
}
