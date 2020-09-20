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
    @ObservedObject private var postListVM: PostListViewModel
    
    init(userId: Int) {
        
        self.postListVM = PostListViewModel(userId: userId)
        
    }
    
    var body: some View {
            VStack {
                 ScrollView {
                    ProfileHeaderView(userId: self.postListVM.userId)
                    Text("Create new post")
                    HStack {
                        VStack {
                            TextField("Title: Enter up to 20 characters", text: self.$postListVM.newPostTitle)
                            TextField("Content: enter up to 1000 characters", text: self.$postListVM.newPostContent)
                                
                        }
                        Button(action: {
                            self.postListVM.createPost()
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                    
                   Text("Posts:")
                        
                    ForEach(self.postListVM.posts, id: \.id) {
                        postVM in
                        NavigationLink(destination: PostDetailView(post: postVM.post)) {
                            PostRowView(post: postVM.post)
                                
                        }.buttonStyle(PlainButtonStyle())
                    }.onDelete(perform: self.postListVM.deletePost)
                        
                    
                 }
                 
             }.onAppear(perform: self.postListVM.getAllPosts)
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(trailing: SearchBarView())
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 3).environmentObject(UserAuthenticationViewModel(id: 3, token: "a1955fcbf50b1eda4a829f7e6a21a1a34fcb5e73", isLoggedIn: true))
    }
}

