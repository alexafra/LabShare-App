//
//  UserFeedWebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 25/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class UserFeedWebService: WebService {
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
//    init (userAuthModel: UserAuthenticationModel) {
//        self.loggedInUserId = userAuthModel.id
//        self.token = userAuthModel.token
//    }
    func generateURLString(userId: Int) -> String {
        return  "http://127.0.0.1:8000/users/\(userId)/feed"
    }
    
    func getAllFeedPosts(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([PostModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
