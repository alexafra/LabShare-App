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

        userPostWebService.getAllUserPosts(userId: userId, completionFailure: {() -> Void in  return }, completionSuccessful: { (posts: [PostModel]?) -> Void in
            if let posts = posts {
                self.posts = posts.map( self.modelToModelView )
            }
        })
    }
    
    func modelToModelView (postModel : PostModel) -> PostViewModel {
        return PostViewModel(post: postModel, userAuthVM: userAuthVM)
    }
    
    
    
//    func getProfilePosts() {
//        let profilePostWebService = ProfilePostsWebService(userAuth: self.userAuthVM.userAuth)
//
//        profilePostWebService.getUserPosts(userId: userId, completionFailure: {() -> Void in  return })  { posts in
//            if let posts = posts {
//                self.posts = posts.map( PostViewModel.init ) //Probs broken
//            }
//        }
//    }
    
    func getFeedPosts() {
        PostWebService().getFeedPosts(userId: userId) { posts in
            if let posts = posts {
                self.posts = posts.map( self.modelToModelView ) //Probs broken
            }
        }
    }
    
    func createPost() {
        let newPostTitle = self.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPostContent = self.newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
        if newPostContent.isEmpty || newPostTitle.isEmpty {
            return
        }
        let newPost = PostEncodable(title: newPostTitle, content:newPostContent, author: 1)
        PostWebService().createPost(post: newPost) { posts in
            if let posts = posts {
                self.posts = posts.map( self.modelToModelView ) //Probs broken
            }
        }
        self.newPostTitle = ""
        self.newPostContent = ""
        
    }
}

class PostViewModel: ObservableObject {
    @Published var post: PostModel
    var userAuthVM: UserAuthenticationViewModel
//    init(post: PostModel) {
//        self.post = post
////        self.userAuthVM = userAuthVM
//    }
    
    
    
    
    //IMPORTANT GET POST NOT QUIRE WORKING!!!!!
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    init(post: PostModel, userAuthVM: UserAuthenticationViewModel) {
        self.post = post
        self.userAuthVM = userAuthVM
    }

    
    func getUserPost() {
        let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)

        userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in  return }, completionSuccessful: { (post: PostModel?) -> Void in
            if let post = post {
                self.post = post
            }
        })
    }

    func updatePost(userId: Int, indexSet: IndexSet) {
//        let postToUpdate = self.posts[indexSet.first!]
//        let newPostTitle = self.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
//        let newPostContent = self.newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
//        if newPostContent.isEmpty || newPostTitle.isEmpty {
//            return
//        }
//
//        let newPost = PostEncodable(title: newPostTitle, content: newPostContent, author: postToUpdate.author)
//
//        PostWebservice().updatePost(postId: postToUpdate.id, post: newPost) { posts in
//            if let posts = posts {
//                self.posts = posts.map( PostViewModel.init )
//            }
//        }
        
    }
    
//    func deletePost() {
//        PostWebservice().deletePost(itemId : self.post.id) { posts in
//            if let posts = posts {
//                self.posts = posts.map( PostViewModel.init )
//            }
//        }
//    }
    
    
}
