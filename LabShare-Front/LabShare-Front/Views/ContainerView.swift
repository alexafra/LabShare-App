//
//  ContainerView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContainerView: View {
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]

        UINavigationBar.appearance().barTintColor = UIColor.white
//        UINavigationBar.appearance().tintColor = .green
//        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        
//        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        
//        self.tabBar.tintColor = UIColor.whiteColor()

    }
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
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
            }.accentColor(.green)
    }
}


struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView().environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
    }
}
