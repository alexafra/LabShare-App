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
    
    init(userId: Int, profileVM: ProfileViewModel) {
        self.postListVM = PostListViewModel(userId: userId)
        self.profileVM = profileVM
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
        ProfileView(userId: 3, profileVM: ProfileViewModel(userId: 10, profile: ProfileModel(id: 5, bio: "I like to dance and sing and be happy", dob: "2/4/1998", occupation: "Undergraduate", employer: "University of Western Australia", owner: UserModel(id: 10, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
            .environmentObject(UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}

