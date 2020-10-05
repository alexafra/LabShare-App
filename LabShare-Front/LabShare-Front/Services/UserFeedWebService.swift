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
    func generateURLString(userId: Int, postFilter: CategoryEnum = CategoryEnum.None) -> String {
        var urlString = "\(hostUrlString)/users/\(userId)/feed"
        if postFilter != CategoryEnum.None {
            urlString = urlString + "?category=\(postFilter.rawValue)"
        }
        return urlString
    }
    
    func getAllFeedPosts(userId: Int, postFilter: CategoryEnum = CategoryEnum.None, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([PostModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postFilter: postFilter)
        
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
