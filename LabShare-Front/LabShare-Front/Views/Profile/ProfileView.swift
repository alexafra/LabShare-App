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
                ProfileView(userId: 37)
                    .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
            }
            
        }
        
    }
}

