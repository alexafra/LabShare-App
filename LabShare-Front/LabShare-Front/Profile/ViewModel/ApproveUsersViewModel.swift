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
    @Published var users: [UserModel] = [UserModel]()
    var userAuthVM: UserAuthenticationViewModel
    
    init (userAuthVM: UserAuthenticationViewModel) {
        self.userAuthVM = userAuthVM
    }
    init() {
        self.userAuthVM = UserAuthenticationViewModel()
    }
}

//struct ApproveUsersViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        ApproveUsersViewModel()
//    }
//}
