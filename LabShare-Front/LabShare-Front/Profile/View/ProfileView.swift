//
//  UserProfile.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct ProfileView: View {
    
//    var userId: Int
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var postListVM: PostListViewModel
    @ObservedObject var profileVM: ProfileViewModel
    
    init(userId: Int) {
        self.postListVM = PostListViewModel(userId: userId, postListType: PostListType.Profile)
        self.profileVM = ProfileViewModel(userId: userId)
    }
    
    var body: some View {
        VStack {
            ScrollView {
               ProfileHeaderView(profileVM: self.profileVM)
               PostListView(postListVM: self.postListVM)
            }
            
        }.navigationBarTitle(Text(""), displayMode: .inline)
        
    //            .navigationBarHidden(true)
                
            
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NavigationView {
                ProfileView(userId: 80)
                    .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
            }
            
        }
        
    }
}

