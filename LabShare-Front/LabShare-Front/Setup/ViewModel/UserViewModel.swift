//
//  UserViewModel.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

class UserViewModel: ObservableObject, Equatable {
    
    @Published var user: UserModel
    
    init(user: UserModel ) {
        self.user = user
    }
    
    static func ==(lhs: UserViewModel, rhs: UserViewModel) -> Bool {
        return (lhs.user.id == rhs.user.id)
    }
    
    func updateIsActive(userAuthVM: UserAuthenticationViewModel) {
         //For register -> Profile edit view
        
        if !userAuthVM.userAuth.isLoggedIn {
            userAuthVM.userAuth.isLoggedIn = true
        }

        let userWebService = UserWebService(userAuth: userAuthVM.userAuth)
        userWebService.updateUser(userId: self.user.id, userModel: self.user, completionFailure: {() -> Void in
//            self.hasCompletedLoading = true
//            self.loadingSuccessful = false


            return

        }, completionSuccessful: { (user: UserModel?) -> Void in
            if let user = user {
                self.user = user
            }

            return
        })
            // //////////NEED TO REPLACE self.userAuthVM.userAuth.isLoggedIn = true
    }
    
    func deleteUser(userAuthVM: UserAuthenticationViewModel) {
        deleteUserClosure(userAuthVM: userAuthVM)()
    }
    
    func deleteUserClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
            
            profileWebService.deleteUser(userId: self.user.id, completionFailure: {() -> Void in
                print("ERROR")
                return
                
                //SUPER USER NEEDS TO CHANGE HERE
            }, completionSuccessful: { (profile: ProfileModel?) -> Void in
                if (true) {
                    //
                } else {
                    //Change to go back feedqee
                }
                
            })
        }
    }
    
}

//struct UserViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        UserViewModel()
//    }
//}
