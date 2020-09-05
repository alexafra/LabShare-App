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

class UserProfileViewModel: ObservableObject {
    @Published var userProfile : UserProfileModel
    init(userProfile: UserProfileModel) {
       self.userProfile = userProfile
    }
    func getUser() {
        UserWebservice().getUser(userId: userProfile.id) { userProfile in
            if let userProfile = userProfile {
                self.userProfile = userProfile
            }
        }
    }
}
