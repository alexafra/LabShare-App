//
//  ContainerView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContainerView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    //May want to think of alternative, does this need to be in a view?
    var body: some View {
        TabView {
            FeedView(userAuthVM: self.userAuthVM)
                .tabItem {
                    Image(systemName: "house")
                }
            ProfileContainerView()
                .tabItem {
                    Image(systemName: "person")
                }
            
        }
        
    }
}


struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView().environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
