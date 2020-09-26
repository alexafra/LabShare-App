//
//  ProfilePostsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostListView: View {
    @ObservedObject var postListVM: PostListViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    
    init (postListVM: PostListViewModel) {
        self.postListVM = postListVM
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            if userAuthVM.userAuth.id == postListVM.userId {
                Text("Create new post").font(Font.headline)
                Divider()
                HStack {
                    VStack {
                        TextField("Title: Enter up to 20 characters", text: self.$postListVM.newPostTitle).padding()
                        Divider()
                        TextField("Content: enter up to 1000 characters", text: self.$postListVM.newPostContent).padding()
                            
                    }.padding(10)
                    Button(action: {
                        self.postListVM.createPost()
                    }){
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .font(Font.largeTitle.weight(.bold))
                            
                    }
                }
                Divider()
            }
            
            Text("Posts:").font(Font.headline).padding(.top, 10)
                
            ForEach(self.postListVM.posts, id: \.post.id) {
                postVM in
                NavigationLink(destination: PostDetailView(postVM: postVM)) {
                    PostRowView(postVM: postVM)
                        
                }.buttonStyle(PlainButtonStyle())
            }
        }.padding()
    }
}

struct PostListView_Previews: PreviewProvider {
    static var previews: some View {
        PostListView(postListVM: PostListViewModel(userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))).environmentObject(UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true))
    }
}
