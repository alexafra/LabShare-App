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
    
    init(userId: Int) {
        self.postListVM = PostListViewModel(userId: userId)
        self.profileVM = ProfileViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
             ScrollView {
                ProfileHeaderView(profileVM: self.profileVM)
                PostListView(postListVM: self.postListVM)
             }
         }.onAppear(perform: self.postListVM.getProfilePosts)
            .navigationBarTitle(Text(""), displayMode: .inline)
            .navigationBarItems(trailing: SearchBarView())
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 3).environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}

