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
    @Published var profile: ProfileModel
    @Published var hasCompletedLoading: Bool = false
    @Published var loadingSuccessful: Bool = false
    
    init(userId: Int) {
        self.userId = userId
        self.hasCompletedLoading = false
        self.loadingSuccessful = false
        self.profile = ProfileModel(ownerId: userId)
    }
    
    init(profile: ProfileModel ) {
        self.userId = profile.owner.id 
        self.profile = profile
        self.hasCompletedLoading = false
        self.loadingSuccessful = false
    }
    
    func deleteProfile(userAuthVM: UserAuthenticationViewModel) {
        deleteProfileClosure(userAuthVM: userAuthVM)()
    }
    
    func deleteProfileClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
            
            profileWebService.deleteUser(userId: self.userId, completionFailure: {() -> Void in
                print("ERROR")
                return
                
            }, completionSuccessful: { (profile: ProfileModel?) -> Void in
                return
            })
        }
    }

    func getProfileClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
            profileWebService.getProfile(userId: self.userId, completionFailure: {() -> Void in
                print("ERROR")
                return
                
            }, completionSuccessful: { (profile: ProfileModel?) -> Void in
                if let profile = profile {
                    self.profile = profile
                }
            })
        }
    }
    func getProfile(userAuthVM: UserAuthenticationViewModel) {
        getProfileClosure(userAuthVM: userAuthVM)()
    }
    
    //Are you sure about profile .... no edited values?
    func updateProfile(userAuthVM: UserAuthenticationViewModel) {
        let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
            
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
        userAuthVM.userAuth.isLoggedIn = true
    }
}

//let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)
//
//userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in  return }, completionSuccessful: { (post: PostModel?) -> Void in
//    if let post = post {
//        self.post = post
//    }
//})

