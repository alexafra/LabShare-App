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
    @Published var profile : ProfileModel
    init(profileModel: ProfileModel) {
       self.profile = profileModel
    }
//    init() {
//        self.userProfile = ProfileModel(from: Decoder)
//    }
    func getUser() {
        UserWebservice().getUser(userId: profile.id) { profile in
            if let profile = profile {
                self.profile = profile
            }
        }
    }
}