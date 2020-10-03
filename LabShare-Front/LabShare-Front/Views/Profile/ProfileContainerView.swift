//
//  myProfileView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 6/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileContainerView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    //May want to think of alternative, does this need to be in a view?
    var body: some View {
        NavigationView {
            ProfileView(userId: userAuthVM.userAuth.id)
        }.accentColor(.green)
    }
}


struct ProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContainerView()
            .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
    }
}
