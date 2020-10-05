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
    //Probs stop optional
    func generateURLString(userId: Int, postFilter: CategoryEnum = CategoryEnum.None, postId: Int? = nil) -> String {
        var urlString =  "\(hostUrlString)/users/\(userId)/posts"
        if postFilter != CategoryEnum.None {
            urlString = urlString + "?category=\(postFilter.rawValue)"
        }
        if let postId = postId {
            urlString = urlString + "/" + String(postId)
        }
        return urlString
    }
    
    func getAllUserPosts(userId: Int, postFilter: CategoryEnum = CategoryEnum.None, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([PostModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postFilter: postFilter)
        
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
    
    
    func createPost (userId: Int, postModel: PostModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {

        let urlString = generateURLString(userId: userId)
        super.post(urlString: urlString, model: postModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
