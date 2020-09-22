//
//  myProfileView.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 6/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileContainerView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State var forceNavLink = true // Bad hack to prevent NavView formatting
    //May want to think of alternative, does this need to be in a view?
    var body: some View {
        NavigationView {
            ProfileView(userId: userAuthVM.userAuth.id)
        }
    }
}


struct ProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContainerView().environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
