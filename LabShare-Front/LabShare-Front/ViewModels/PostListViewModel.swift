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
    
    init (userId: Int) {
        self.userId = userId
    }
    func getAllUserPosts(userAuthVM: UserAuthenticationViewModel) {
        getAllUserPostsClosure(userAuthVM: userAuthVM)()
    }
    func getAllUserPostsClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)

            userPostWebService.getAllUserPosts(userId: self.userId, completionFailure: {() -> Void in return }, completionSuccessful: { (posts: [PostModel]?) -> Void in
                if let posts = posts {
                    self.posts = posts.map( self.modelToViewModel )
                }
            })
        }
    }
    
    func modelToViewModel (postModel : PostModel) -> PostViewModel {
        return PostViewModel(post: postModel)
    }
    
    
    func getFeedPosts(userAuthVM: UserAuthenticationViewModel) {
        getFeedPostsClosure(userAuthVM: userAuthVM)()
    }
    
    func getFeedPostsClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userFeedWebService = UserFeedWebService(userAuth: userAuthVM.userAuth)
            userFeedWebService.getAllFeedPosts(userId: userAuthVM.userAuth.id,
               completionFailure: {() -> Void in
                    return
               }, completionSuccessful: {(posts: [PostModel]?) -> Void in
                    if let posts = posts {
                        self.posts = posts.map( self.modelToViewModel ) //Probs broken
                    }
                    return
               }
            )
        }
    }
    
    func createPost(userAuthVM: UserAuthenticationViewModel) {
        let newPostTitle = self.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPostContent = self.newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
        if newPostContent.isEmpty || newPostTitle.isEmpty {
            return
        }
        
        let newPost = PostModel(title: newPostTitle, content:newPostContent)
        
        let userFeedWebService = UserFeedWebService(userAuth: userAuthVM.userAuth)
        userFeedWebService.createFeedPost(userId: userAuthVM.userAuth.id, postModel: newPost,
           completionFailure: {() -> Void in
                self.newPostTitle = ""
                self.newPostContent = ""
                return
           }, completionSuccessful: {(post: PostModel?) -> Void in
                if let post = post {
                    self.posts.insert(self.modelToViewModel(postModel: post), at: 0) //Probs broken
                }
                self.newPostTitle = ""
                self.newPostContent = ""
           }
       )
    }
}

class PostViewModel: ObservableObject {
    @Published var post: PostModel
    @Published var makingRequest: Bool = false
    @Published var requestSuccessful: Bool = false
    init (post: PostModel) {
        self.post = post
    }
    init () {
        self.post = PostModel()
    }
    
    //When you transition to new view (for updating), you want to still use a PostViewModel BUT you need to make sure its a copy. THis can be done simply by using this initialiser i believe, because PostModel is a struct and structs are copy by value
    
    func getUserPost(userAuthVM: UserAuthenticationViewModel) {
        let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)

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
