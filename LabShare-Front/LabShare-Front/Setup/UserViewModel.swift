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
    
    
}

//struct UserViewModel_Previews: PreviewProvider {
//    static var previews: some View {
//        UserViewModel()
//    }
//}
