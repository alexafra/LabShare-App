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
    
//    let objectWillChange = ObservableObjectPublisher()
//    let didChange = PassthroughSubject<PostListViewModel, Never>()
    private let titleCharacterLimit = 30
    @Published var userId: Int
    @Published var newPostTitle: String = ""
    @Published var newPostContent: String = ""
    @Published var newPostCategory: CategoryEnum = CategoryEnum.None

    @Published var postFilter: CategoryEnum = CategoryEnum.None
           
    @Published var posts = [PostViewModel]() //whenever you change the posts, it will publish an event
    @Published var postListType: PostListType
    
//    var dateString: String {
//        return ""
//    }
    
    
    init (userId: Int, postListType: PostListType) {
        self.userId = userId
        self.postListType = postListType
    }
    func getAllUserPosts(userAuthVM: UserAuthenticationViewModel) {
        getAllUserPostsClosure(userAuthVM: userAuthVM)()
    }
    
    func getAllPostsClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        if self.postListType == PostListType.Feed {
            return {
                self.getFeedPostsClosure(userAuthVM: userAuthVM)()
            }
        } else {
            return {
                self.getAllUserPostsClosure(userAuthVM: userAuthVM)()
            }
        }
        
    }
    func getAllPosts(userAuthVM: UserAuthenticationViewModel) {
        getAllPostsClosure(userAuthVM: userAuthVM)()
    }
    func getAllUserPostsClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)

            userPostWebService.getAllUserPosts(userId: self.userId, postFilter: self.postFilter, completionFailure: {() -> Void in return }, completionSuccessful: { (posts: [PostModel]?) -> Void in
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
            userFeedWebService.getAllFeedPosts(userId: userAuthVM.userAuth.id, postFilter: self.postFilter,
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
        
        let newPost = PostModel(title: newPostTitle, content:newPostContent, category: newPostCategory, authorId: userAuthVM.userAuth.id)
        
        let userPostWebService = UserPostsWebService(userAuth: userAuthVM.userAuth)
        userPostWebService.createPost(userId: userAuthVM.userAuth.id, postModel: newPost,
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



enum PostListType {
    case Profile
    case Feed
}

