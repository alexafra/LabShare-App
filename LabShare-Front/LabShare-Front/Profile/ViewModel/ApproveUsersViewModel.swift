//
//  ApproveUsersViewModel.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ApproveUsersViewModel: ObservableObject {
    @Published var users: [UserViewModel] = [UserViewModel]()
    
    func delete() {
        
    }
    
    func getNonApproved(userAuthVM: UserAuthenticationViewModel) {
        getNonApprovedClosure(userAuthVM: userAuthVM)()
    }

    func getNonApprovedClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
//            let userWebService = UserWebService(userAuth: userAuthVM.userAuth)
//
//            userWebService.getUsersSearchBar(completionFailure: {() -> Void in
//                return
//
//            },
//            completionSuccessful: { (users: [UserModel]?) -> Void in
//                if let users = users {
//                    self.users = users
//                }
//            }
//            )
        }
    }
    
//    func deleteUser(userAuthVM: UserAuthenticationViewModel) {
//        deleteUserClosure(userAuthVM: userAuthVM)()
//    }
//
//    func deleteUserClosure (userAuthVM: UserAuthenticationViewModel) -> () -> () {
//        return {
//            let profileWebService = ProfileWebService(userAuth: userAuthVM.userAuth)
//
//            profileWebService.deleteUser(userId: self.users, completionFailure: {() -> Void in
//                print("ERROR")
//                return
//
//                //SUPER USER NEEDS TO CHANGE HERE
//            }, completionSuccessful: { (profile: ProfileModel?) -> Void in
//                if (true) {
//                    //
//                } else {
//                    //Change to go back feedqee
//                }
//
//            })
//        }
//    }
}


//struct ApproveUsersViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ApproveUsersViewModel()
//    }
//}
