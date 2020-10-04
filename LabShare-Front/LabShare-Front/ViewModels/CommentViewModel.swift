//
//  CommentViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 3/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//




import Foundation
import SwiftUI
import Combine

class CommentViewModel: ObservableObject {
    
    @Published var commentModel: CommentModel
    private let commentCharacterLimit = 500
    
    var dateMessageString: String {
        var dateMessage: String
        let delta = Date().timeIntervalSince(self.commentModel.dateCreated)
        var unit: Int
        if delta < 120 {
            dateMessage = "Just now"
        } else if delta < 60 * 60 {
            unit = Int(delta / 60)
            if (unit == 1) {
                dateMessage = "\(unit) minute ago"
            } else {
                dateMessage = "\(unit) minutes ago"
            }
        } else if delta < 60 * 60 * 24 {
            unit = Int(delta / (60 * 60))
            if (unit == 1) {
                dateMessage = "\(unit) hour ago"
            } else {
                dateMessage = "\(unit) hours ago"
            }
        } else if delta < 60 * 60 * 24 * 7 {
            unit = Int(delta / (60 * 60 * 24))
            if (unit == 1) {
                dateMessage = "\(unit) day ago"
            } else {
                dateMessage = "\(unit) days ago"
            }
        } else if delta < 60 * 60 * 24 * 7 * 4 {
            unit = Int(delta / (60 * 60 * 24 * 7))
            if (unit == 1) {
                dateMessage = "\(unit) week ago"
            } else {
                dateMessage = "\(unit) weeks ago"
            }
        } else if delta < 60 * 60 * 24 * 7 * 4 * 12 {
            unit = Int(delta / (60 * 60 * 24 * 7 * 4))
            if (unit == 1) {
                dateMessage = "\(unit) month ago"
            } else {
                dateMessage = "\(unit) months ago"
            }
        } else if delta < 60 * 60 * 24 * 7 * 4 * 12 * 10 {
            unit = Int(delta / (60 * 60 * 24 * 7 * 4 * 12))
            if (unit == 1) {
                dateMessage = "\(unit) year ago"
            } else {
                dateMessage = "\(unit) years ago"
            }
        } else {
            unit = Int(delta / (60 * 60 * 24 * 7 * 4 * 12 * 10))
            if (unit == 1) {
                dateMessage = "\(unit) decade ago"
            } else {
                dateMessage = "\(unit) decades ago"
            }
        }
        return dateMessage
    }
    
    init (commentModel: CommentModel) {
        self.commentModel = commentModel
    }
    
    init () {
        self.commentModel = CommentModel()
    }
    
    init (userId: Int, postId: Int, commentId: Int) {
        self.commentModel = CommentModel(userId: userId, postId: postId, commentId: commentId)
    }
    
    func getCommentClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let commentWebService = CommentsWebService(userAuth: userAuthVM.userAuth)

            commentWebService.getComment(userId: self.commentModel.author.id, postId: self.commentModel.postId, completionFailure: {() -> Void in
                    return
                },
            completionSuccessful: { (commentModel: CommentModel?) -> Void in
                if let commentModel = commentModel {
                    self.commentModel = commentModel
                }
                return
            })
        }
    }

    func deleteComment (userAuthVM: UserAuthenticationViewModel) {
        deleteCommentClosure(userAuthVM: userAuthVM)()
    }
    
    func deleteCommentClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let commentWebService = CommentsWebService(userAuth: userAuthVM.userAuth)

            commentWebService.deleteComment(userId: self.commentModel.author.id, postId: self.commentModel.postId, commentId: self.commentModel.id, completionFailure: {() -> Void in
                    return
                },
            completionSuccessful: { (post: CommentModel?) -> Void in
                
                //GO BACK TO USER FEED
                //NAV BACK TWICE
                return
                
                
            })
        }
    }
    
    func updateComment(userAuthVM: UserAuthenticationViewModel) {
        //CHeck if there has been any change
        if commentModel.content.isEmpty {
            return
            //Do nothing
        }
//        self.makingRequest = true
        let userCommentsWebService = CommentsWebService(userAuth: userAuthVM.userAuth)
        userCommentsWebService.updateComment(userId: self.commentModel.author.id, postId: self.commentModel.postId, commentModel: self.commentModel,
           completionFailure: {() -> Void in
//                self.makingRequest = false
//                self.requestSuccessful = false
                return
           },
           completionSuccessful: { (commentModel: CommentModel?) -> Void in
//                self.makingRequest = false
//                self.requestSuccessful = true
                if let commentModel = commentModel {
                    self.commentModel = commentModel
                }
                return
                
            }
        )
    }
    
    
}
