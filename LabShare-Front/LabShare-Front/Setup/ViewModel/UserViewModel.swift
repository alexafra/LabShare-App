//
//  UserViewModel.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

class UserViewModel: ObservableObject {
    @Published var user: UserModel
    
    init(user: UserModel ) {
        self.user = user
    }
    
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
    
}

//struct UserViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        UserViewModel()
//    }
//}
