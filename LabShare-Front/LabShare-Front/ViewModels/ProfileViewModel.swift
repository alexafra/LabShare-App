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
    
    init(userId: Int) {
        self.userId = userId
        self.hasCompletedLoading = false
        self.loadingSuccessful = false
    }
    
    init(userId: Int, profile: ProfileModel) {
        self.userId = userId
        self.profile = profile
    }

    func getProfile() {
        ProfileWebService().getProfile(userId: self.userId) { profile in
            if let profile = profile {
                self.profile = ProfileModel(profile: profile)
            }
        }
    }
    
    func updateProfile() {
        ProfileWebService().updateProfile(profileModel: self.profile) { successfulCompletion in
            self.hasCompletedLoading = true
            self.loadingSuccessful = successfulCompletion
        }
    }
}

