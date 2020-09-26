//
//  UserProfile.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
//    var userId: Int
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var postListVM: PostListViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    init(userId: Int, userAuthVM: UserAuthenticationViewModel) {
        self.postListVM = PostListViewModel(userId: userId, userAuthVM: userAuthVM)
        self.profileVM = ProfileViewModel(userId: userId, userAuthVM: userAuthVM)
    }
    
    var body: some View {
        VStack {
            ScrollView {
               ProfileHeaderView(profileVM: self.profileVM)
               PostListView(postListVM: self.postListVM)
            }
            
        }.navigationBarTitle(Text(""), displayMode: .inline)
    //            .navigationBarHidden(true)
                .onAppear(perform: self.postListVM.getAllUserPosts)
            
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 1, userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
            .environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
    }
}

