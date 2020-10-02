//
//  CommentListViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 3/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

class CommentListViewModel: ObservableObject {
    
    @Published var comments = [CommentViewModel]()
    @Published var userId: Int
    @Published var postId: Int
    @Published var newCommentContent: String = ""
    
    init(userId: Int, postId: Int) {
        self.userId = userId
        self.postId = postId
    }
    
    func getAllComments (userAuthVM: UserAuthenticationViewModel) {
        getAllCommentsClosure(userAuthVM: userAuthVM)()
    }
    
    func getAllCommentsClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let commentsWebService = CommentsWebService(userAuth: userAuthVM.userAuth)

            commentsWebService.getAllComments(userId: self.userId, postId: self.postId,
                  completionFailure: {() -> Void in
                    return
                    
                  },
                  completionSuccessful: { (comments: [CommentModel]?) -> Void in
                    if let comments = comments {
                        self.comments = comments.map( self.modelToViewModel )
                    }
                  }
            )
        }
    }
    
    func modelToViewModel (commentModel : CommentModel) -> CommentViewModel {
        return CommentViewModel(commentModel: commentModel)
    }
    
    func createComment(userAuthVM: UserAuthenticationViewModel) {
        let newCommentContent = self.newCommentContent.trimmingCharacters(in: .whitespacesAndNewlines)
        if newCommentContent.isEmpty {
            return
        }
        
        let newComment = CommentModel(content: newCommentContent, postId: self.postId, authorId: userAuthVM.userAuth.id)
        
        let commentsWebService = CommentsWebService(userAuth: userAuthVM.userAuth)
        
        commentsWebService.createComment(userId: self.userId, postId: self.postId, commentModel: newComment,
             completionFailure: {() -> Void in
                  self.newCommentContent = ""
                  return
             }, completionSuccessful: {(commentModel: CommentModel?) -> Void in
                  if let commentModel = commentModel {
                      self.comments.insert(self.modelToViewModel(commentModel: commentModel), at: 0) //Probs broken
                  }
                  self.newCommentContent = ""
             }
        )

        
        
        
        
    }
}
