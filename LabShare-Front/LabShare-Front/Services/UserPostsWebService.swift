//
//  Webservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

//Enum to create URLS

import Foundation

class UserPostsWebService: WebService {
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
//    init (userAuthModel: UserAuthenticationModel) {
//        self.loggedInUserId = userAuthModel.id
//        self.token = userAuthModel.token
//    }
    func generateURLString(userId: Int, postId: Int? = nil) -> String {
        var urlString =  "http://127.0.0.1:8000/users/\(userId)/posts"
        if let postId = postId {
            urlString = urlString + String(postId)
        }
        return urlString
    }
    
    func getAllUserPosts(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([PostModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func getUserPost (userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {

        let urlString = generateURLString(userId: userId, postId: postId)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func updateUserPost (userId: Int, postModel: PostModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postId: postModel.id)
        super.update(urlString: urlString, model: postModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func deleteUserPost (userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postId: postId)
        super.delete(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
