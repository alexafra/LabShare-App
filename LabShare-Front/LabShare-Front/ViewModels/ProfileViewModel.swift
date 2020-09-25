//
//  UserProfileViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userId: Int
    @Published var profile = ProfileModel()
    @Published var hasCompletedLoading: Bool = false
    @Published var loadingSuccessful: Bool = false
    var userAuthVM: UserAuthenticationViewModel
    
    init(userId: Int, userAuthVM: UserAuthenticationViewModel) {
        self.userId = userId
        self.hasCompletedLoading = false
        self.loadingSuccessful = false
        self.userAuthVM = userAuthVM
    }
    
    init(userId: Int, profile: ProfileModel, userAuthVM: UserAuthenticationViewModel ) {
        self.userId = userId
        self.profile = profile
        self.userAuthVM = userAuthVM
    }

    func getProfile() {
        let profileWebService = ProfileWebService(userAuth: self.userAuthVM.userAuth)
        profileWebService.getProfile(userId: self.userId, completionFailure: {() -> Void in
            return
            
        }, completionSuccessful: { (profile: ProfileModel?) -> Void in
            if let profile = profile {
                self.profile = profile
            }
        })
    }
    
    func updateProfile() {
        let profileWebService = ProfileWebService(userAuth: self.userAuthVM.userAuth)
            
        profileWebService.updateProfile(profileModel: self.profile, completionFailure: {() -> Void in
            self.hasCompletedLoading = true
            self.loadingSuccessful = false
            return
            
        }, completionSuccessful: { (profile: ProfileModel?) -> Void in
            self.hasCompletedLoading = true
            self.loadingSuccessful = true
            if let profile = profile {
                self.profile = profile
            }
        })
    }
}

//let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)
//
//userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in  return }, completionSuccessful: { (post: PostModel?) -> Void in
//    if let post = post {
//        self.post = post
//    }
//})

