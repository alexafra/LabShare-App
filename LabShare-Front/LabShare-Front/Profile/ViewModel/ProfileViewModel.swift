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
    
    var dobString: String {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .short
        return dateFormatter1.string(from: profile.dob)
    }
    var dobExists: Bool {
        let dateString = "01/01/1970"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let defaultDate = dateFormatter.date(from: dateString) else {
            return false
        }
        return defaultDate != profile.dob
    }
    var occupationExists: Bool {
        return !profile.occupation.isEmpty
    }
    var employerExists: Bool {
        return !profile.employer.isEmpty
    }
    var bioExists: Bool {
        return !profile.bio.isEmpty
    }
    
    
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
                
                //SUPER USER NEEDS TO CHANGE HERE
            }, completionSuccessful: { (profile: ProfileModel?) -> Void in
                if (true) {
                    userAuthVM.userAuth.isLoggedIn = false
                } else {
                    //Change to go back feedqee
                }
                
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
         //For register -> Profile edit view
        
        if !userAuthVM.userAuth.isLoggedIn {
            userAuthVM.userAuth.isLoggedIn = true
        }
        
        let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
        profileWebService.updateProfile(profileModel: self.profile, completionFailure: {() -> Void in
//            self.hasCompletedLoading = true
//            self.loadingSuccessful = false
            
            
            return
            
        }, completionSuccessful: { (profile: ProfileModel?) -> Void in
            if let profile = profile {
                self.profile = profile
            }
            
            return
        })
        
        let userWebService = UserWebService(userAuth: userAuthVM.userAuth)
        userWebService.updateUser(userId: self.profile.owner.id, userModel: self.profile.owner, completionFailure: {() -> Void in
//            self.hasCompletedLoading = true
//            self.loadingSuccessful = false
            
            
            return
            
        }, completionSuccessful: { (user: UserModel?) -> Void in
            if let user = user {
                self.profile.owner = user
            }
            
            return
        })
            // //////////NEED TO REPLACE self.userAuthVM.userAuth.isLoggedIn = true
    }
    func setAdmin(userAuthVM: UserAuthenticationViewModel) {
         //For register -> Profile edit view
        
        if (!self.profile.owner.isStaff) {
            var userModel: UserModel = self.profile.owner
            userModel.isStaff = true
            let userWebService = UserWebService(userAuth: userAuthVM.userAuth)
            userWebService.updateUser(userId: self.profile.owner.id, userModel: userModel, completionFailure: {() -> Void in
                userModel.isStaff = false
                return
                
            }, completionSuccessful: { (user: UserModel?) -> Void in
                return
            })
        }
        
    }
    
    func removeAdmin(userAuthVM: UserAuthenticationViewModel) {
         //For register -> Profile edit view
        
        if (self.profile.owner.isStaff) {
            var userModel: UserModel = self.profile.owner
            userModel.isStaff = false
            let userWebService = UserWebService(userAuth: userAuthVM.userAuth)
            userWebService.updateUser(userId: self.profile.owner.id, userModel: userModel, completionFailure: {() -> Void in
                userModel.isStaff = true
                return
                
            }, completionSuccessful: { (user: UserModel?) -> Void in
                return
            })
        }
    }
    
}

//let userPostWebService = UserPostsWebService(userAuth: self.userAuthVM.userAuth)
//
//userPostWebService.getUserPost(userId: self.post.author.id, postId: self.post.id, completionFailure: {() -> Void in  return }, completionSuccessful: { (post: PostModel?) -> Void in
//    if let post = post {
//        self.post = post
//    }
//})

