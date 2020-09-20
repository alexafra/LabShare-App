//
//  StartView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct StartView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    //Check if id = -1 OR token is empty for now, in future, may want to hit api to confirm valid token
    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn == false {
                SetUpView()
            } else {
                ProfileContainerView()
            }
        }
    }
}

struct StartView_Previews: PreviewProvider {
//    var environment2 = UserAuthenticationViewModel()
    static var previews: some View {
        StartView().environmentObject(UserAuthenticationViewModel(id: 3, token: "a1955fcbf50b1eda4a829f7e6a21a1a34fcb5e73", isLoggedIn: true))
    }
}
