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

class PostListViewModel: ObservableObject {
//    @Published var loggedInUserId: Int
    @Published var userId: Int
    @Published var newPostTitle: String = ""
    @Published var newPostContent: String = ""
    @Published var posts = [PostModel]() //whenever you change the posts, it will publish an event
    
    init (userId: Int) {
        self.userId = userId
    }
    func getAllPosts() {
        PostWebservice().getAllPosts(userId: userId) { posts in
            if let posts = posts {
                self.posts = posts.map( PostModel.init ) //Probs broken
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
        PostWebservice().createPost(post: newPost) { posts in
        
            if let posts = posts {
                self.posts = posts.map( PostModel.init ) //Probs broken
            }
        }
        self.newPostTitle = ""
        self.newPostContent = ""
        
    }
}

class PostViewModel: ObservableObject {
    @Published var post: PostModel
    
    init(post: PostModel) {
        self.post = post
    }
    
//    var id: Int { return self.post.id }
//    var title: String { return self.post.title }
//    var content: String { return self.post.content }
//    var date_created: String { return self.post.dateCreated }
//    var author: UserModel { return self.post.author }
    
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
    
    func deletePost() {
        
        PostWebservice().deletePost(itemId : self.post.id) { posts in
            if let posts = posts {
                self.posts = posts.map( PostViewModel.init )
            }
        }
    }
    
    
}
