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
    init(userId: Int) {
       self.userId = userId
    }

    func getProfile() {
        UserWebservice().getProfile(userId: self.userId) { profile in
            if let profile = profile {
                self.profile = ProfileModel(profile: profile)
            }
        }
    }
}

