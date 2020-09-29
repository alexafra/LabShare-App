//
//  PostViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 30/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class PostViewModel: ObservableObject {
    let didChange = PassthroughSubject<PostViewModel,Never>()
    private let titleCharacterLimit = 30
    @Published var post: PostModel
    @Published var makingRequest: Bool = false
    @Published var requestSuccessful: Bool = false
    
    
    var dateMessageString: String {
        var dateMessage: String
        let delta = Date().timeIntervalSince(self.post.dateCreated)
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
    
    init (post: PostModel) {
        self.post = post
    }
    
    init (userId: Int, postId: Int) {
        self.post = PostModel(userId: userId, postId: postId)
    }
    
    init () {
        self.post = PostModel()
    }
    
    func getUserPost(userAuthVM: UserAuthenticationViewModel) {
        getPostClosure(userAuthVM: userAuthVM)()
    }
    
    func getPostClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)

            userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in
                    return
                },
            completionSuccessful: { (post: PostModel?) -> Void in
                if let post = post {
                    self.post = post
                }
                return
            })
        }
    }

    func deletePost (userAuthVM: UserAuthenticationViewModel) {
        deletePostClosure(userAuthVM: userAuthVM)()
    }
    
    func deletePostClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)

            userPostWebService.deleteUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in
                    return
                },
            completionSuccessful: { (post: PostModel?) -> Void in
                
                //GO BACK TO USER FEED
                //NAV BACK TWICE
                return
                
                
            })
        }
    }
    
    //Are you sure about profile .... no edited values?
    func updatePost(userAuthVM: UserAuthenticationViewModel) {
        //CHeck if there has been any change
        if post.content.isEmpty || post.title.isEmpty {
            return
            //Do nothing
        }
        self.makingRequest = true
        let userPostsWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)
        userPostsWebService.updateUserPost(userId: self.post.author.id, postModel: self.post,
           completionFailure: {() -> Void in
                self.makingRequest = false
                self.requestSuccessful = false
                return
           },
           completionSuccessful: { (postModel: PostModel?) -> Void in
                self.makingRequest = false
                self.requestSuccessful = true
                if let postModel = postModel {
                    self.post = postModel
                }
                
            }
        )
    }
    
}
