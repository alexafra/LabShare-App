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
    @ObservedObject private var keyboard = KeyboardResponder()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            if userAuthVM.userAuth.id == postListVM.userId || postListVM.postListType == PostListType.Feed {
                HStack {
                    Text("Create new post").font(Font.headline)
                    Spacer()
                    Button(action: {
                        self.postListVM.createPost(userAuthVM: self.userAuthVM)
                    }){
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.green)
                            .font(Font.largeTitle.weight(.bold))
                            
                    }
                }
                VStack (alignment: .leading) {
                    Text("Title:")
                    TextField("", text: self.$postListVM.newPostTitle)
                    Divider()
                    VStack(alignment: .leading) {
                        Text("Content:")
                        ZStack {
                            MultilineTextView(text: self.$postListVM.newPostContent)
                            Text(self.postListVM.newPostContent).opacity(0).padding(.top, 12)
                        }
                    }
                        
                }.modifier(MultiLineTextFieldAuthorization())
                    .padding(10)
                    Divider()
            }
            
            Text("Posts:").font(Font.headline).padding(.top, 10)
                
            ForEach(self.postListVM.posts, id: \.post.id) {
                postVM in
                
                    PostRowView(postVM: postVM)
                        
                
            }
        }.padding()
        .onAppear(perform: self.postListVM.getAllPostsClosure(userAuthVM: userAuthVM))
            
    }
}

struct PostListView_Previews: PreviewProvider {
    static let  userAuthVM: UserAuthenticationViewModel = UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true)
    static var previews: some View {
        Group {
            VStack {
                NavigationView {
                    ScrollView {
                        PostListView(postListVM: PostListViewModel(userId: 72, postListType: PostListType.Profile)).environmentObject(UserAuthenticationViewModel(id: 72, token: "d4e3814547b0b328f3baae5ea78a3b1417464386", isLoggedIn: true))
                    }
                    
                }
            }
            
        }
        
        
    }
}
