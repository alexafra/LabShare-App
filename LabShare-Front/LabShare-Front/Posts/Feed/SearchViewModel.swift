//
//  SearchViewModel.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 4/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class SearchViewModel: ObservableObject {
    @Published var users: [UserModel] = [UserModel]()
    var userAuthVM: UserAuthenticationViewModel
    @Published var userQuery: String = ""
//    {
//        didSet {
//            getUsersSearch(userAuthVM: userAuthVM)
//        }
//    }
    init (userAuthVM: UserAuthenticationViewModel) {
        self.userAuthVM = userAuthVM
    }
    init() {
        self.userAuthVM = UserAuthenticationViewModel()
    }
    
    func getUsersSearch(userAuthVM: UserAuthenticationViewModel) {
        getUsersSearchClosure(userAuthVM: userAuthVM)()
    }
//    getUsersSearchBar
    func getUsersSearchClosure(userAuthVM: UserAuthenticationViewModel) -> () -> () {
        return {
            let userWebService = UserWebService(userAuth: userAuthVM.userAuth)

            userWebService.getUsersSearchBar(queryString: self.userQuery, completionFailure: {() -> Void in
                    return
                
                },
                completionSuccessful: { (users: [UserModel]?) -> Void in
                    if let users = users {
                        self.users = users
                    }
                }
            )
        }
    }
}
