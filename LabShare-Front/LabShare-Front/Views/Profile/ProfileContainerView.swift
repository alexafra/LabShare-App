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
    //May want to think of alternative, does this need to be in a view?
    var body: some View {
        NavigationView {
            ProfileView(userId: userAuthVM.userAuth.id)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarHidden(true)
        }.accentColor(.green)
    }
}


struct ProfileContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileContainerView()
            .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
    }
}
