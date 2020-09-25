//
//  PostListViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//



import Foundation
import SwiftUI
import Combine

//Probably can use this for the feed
class PostListViewModel: ObservableObject {
    @Published var userId: Int
    @Published var newPostTitle: String = ""
    @Published var newPostContent: String = ""
    @Published var posts = [PostViewModel]() //whenever you change the posts, it will publish an event
    var userAuthVM: UserAuthenticationViewModel
    
    init (userAuthVM: UserAuthenticationViewModel) {
        self.userId = userAuthVM.userAuth.id
        self.userAuthVM = userAuthVM
    }
    
    init (userId: Int, userAuthVM: UserAuthenticationViewModel) {
        self.userId = userId
        self.userAuthVM = userAuthVM
    }
    func getAllUserPosts() {
        let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)

        userPostWebService.getAllUserPosts(userId: userId, completionFailure: {() -> Void in return }, completionSuccessful: { (posts: [PostModel]?) -> Void in
            if let posts = posts {
                self.posts = posts.map( self.modelToModelView )
            }
        })
    }
    
    func modelToModelView (postModel : PostModel) -> PostViewModel {
        return PostViewModel(post: postModel, userAuthVM: userAuthVM)
    }
    
    
    func getFeedPosts() {
        let userFeedWebService = UserFeedWebService(userAuth: self.userAuthVM.userAuth)
        userFeedWebService.getAllFeedPosts(userId: userAuthVM.userAuth.id,
           completionFailure: {() -> Void in
                return
           }, completionSuccessful: {(posts: [PostModel]?) -> Void in
                if let posts = posts {
                    self.posts = posts.map( self.modelToModelView ) //Probs broken
                }
       })
    }
    
    func createPost() {
        let newPostTitle = self.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPostContent = self.newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
        if newPostContent.isEmpty || newPostTitle.isEmpty {
            return
        }
        
        let newPost = PostModel(title: newPostTitle, content:newPostContent)
        
        let userFeedWebService = UserFeedWebService(userAuth: self.userAuthVM.userAuth)
        userFeedWebService.createFeedPost(userId: userAuthVM.userAuth.id, postModel: newPost,
           completionFailure: {() -> Void in
                self.newPostTitle = ""
                self.newPostContent = ""
                return
           }, completionSuccessful: {(post: PostModel?) -> Void in
                if let post = post {
                    self.posts.insert(self.modelToModelView(postModel: post), at: 0) //Probs broken
                }
                self.newPostTitle = ""
                self.newPostContent = ""
           }
       )
    }
}

class PostViewModel: ObservableObject {
    @Published var post: PostModel
    var userAuthVM: UserAuthenticationViewModel
    
    //When you transition to new view (for updating), you want to still use a PostViewModel BUT you need to make sure its a copy. THis can be done simply by using this initialiser i believe, because PostModel is a struct and structs are copy by value
    init(post: PostModel, userAuthVM: UserAuthenticationViewModel) {
        self.post = post
        self.userAuthVM = userAuthVM
    }
    
    func getUserPost() {
        let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)

        userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in
                return
            },
        completionSuccessful: { (post: PostModel?) -> Void in
            if let post = post {
                self.post = post
            }
        })
    }

    //Are you sure about profile .... no edited values?
    func updatePost() {
        //CHeck if there has been any change
        if post.content.isEmpty || post.title.isEmpty {
            return
            //Do nothing
        }
        
        let userPostsWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)
        userPostsWebService.updateUserPost(userId: self.post.author.id, postModel: self.post,
           completionFailure: {() -> Void in
                return
           },
           completionSuccessful: { (postModel: PostModel?) -> Void in
                if let postModel = postModel {
                    self.post = postModel
                }
            }
        )
    }
    
}


//class PostViewModel: ObservableObject {
//    @Published var post: PostModel
//    @Published var editedPostTitle: String
//    @Published var editedPostContent: String
//    var userAuthVM: UserAuthenticationViewModel
//    init(post: PostModel, userAuthVM: UserAuthenticationViewModel) {
//        self.post = post
//        self.userAuthVM = userAuthVM
//        self.editedPostTitle = ""
//        self.editedPostContent = ""
//    }
//
//    func editViewAppear () {
//        self.editedPostContent = self.post.content
//        self.editedPostTitle = self.post.title
//    }
//
//    func getUserPost() {
//        let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)
//
//        userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in
//                return
//            },
//        completionSuccessful: { (post: PostModel?) -> Void in
//            if let post = post {
//                self.post = post
//            }
//        })
//    }
//
//    //Are you sure about profile .... no edited values?
//    func updatePost() {
//        let newPostTitle = self.editedPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
//        let newPostContent = self.editedPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        //CHeck if there has been any change
//        if editedPostContent == post.content && editedPostTitle == post.title {
//            return
//            //Do nothing
//        }
//
//        var updatedPost = self.post
//        updatedPost.content = newPostContent
//        updatedPost.title = newPostTitle
//
//        let userPostsWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)
//        userPostsWebService.updateUserPost(userId: self.post.author.id, postModel: updatedPost,
//           completionFailure: {() -> Void in
//                return
//           },
//           completionSuccessful: { (postModel: PostModel?) -> Void in
//                if let postModel = postModel {
//                    self.post = postModel
//                }
//            }
//        )
//    }
//
//}
