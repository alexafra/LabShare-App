//
//  CommentWebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 3/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class CommentsWebService: WebService {
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
//    init (userAuthModel: UserAuthenticationModel) {
//        self.loggedInUserId = userAuthModel.id
//        self.token = userAuthModel.token
//    }
    func generateURLString(userId: Int, postId: Int, commentId: Int? = nil) -> String {
        var urlString =  "\(hostUrlString)/users/\(userId)/posts/\(postId)/comments"
        if let commentId = commentId {
            urlString = urlString + "/" + String(commentId)
        }
        return urlString
    }
    
    func getAllComments(userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([CommentModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postId: postId)
        
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func getComment (userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (CommentModel?) -> ()) {

        let urlString = generateURLString(userId: userId, postId: postId)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    //Dont think we will implement an edit comment
    func updateComment (userId: Int, postId: Int, commentModel: CommentModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (CommentModel?) -> ()) {

        let urlString = generateURLString(userId: userId, postId: postId, commentId: commentModel.id)
        super.update(urlString: urlString, model: commentModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func deleteComment (userId: Int, postId: Int, commentId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (CommentModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postId: postId, commentId: commentId)
        super.delete(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    
    func createComment (userId: Int, postId: Int, commentModel: CommentModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (CommentModel?) -> ()) {

        let urlString = generateURLString(userId: userId, postId: postId)
        super.post(urlString: urlString, model: commentModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
