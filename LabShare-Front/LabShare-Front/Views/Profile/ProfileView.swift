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
             List {
                ProfileHeaderView(userId: self.postListVM.userId)
                Section(header: Text("Create new post")) {
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

                }
                Section(header: Text("Posts:")) {
                    ForEach(self.postListVM.posts, id: \.id) {
                        postVM in
                        NavigationLink(destination: PostDetailView(post: postVM.post)) {
                            PostRowView(post: postVM.post)
                        }
                    }.onDelete(perform: self.postListVM.deletePost)
                }
            }.navigationBarItems(trailing: SearchBarView())
        }.onAppear(perform: self.postListVM.getAllPosts)
        
    }
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 3)
    }
}

