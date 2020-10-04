//
//  ProfilePostsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

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
                            TextEditor(text: self.$postListVM.newPostContent)
                            Text(self.postListVM.newPostContent).opacity(0).padding(.top, 12)
                        }
                    }
                    Divider()
//                    Menu(content: {
//                        Button(action: {
//                            self.postListVM.postFilter = PostFilter.Reagents
//                            self.postListVM.getAllPosts(userAuthVM: userAuthVM)
//                        }, label: {
//                            Text("Reagents")
//                        })
//                        Button(action: {
//                            self.postListVM.postFilter = PostFilter.Equipment
//                            self.postListVM.getAllPosts(userAuthVM: userAuthVM)
//                        }, label: {
//                            Text("Equipment")
//                        })
//                        Button(action: {
//                            self.postListVM.postFilter = PostFilter.Expertise
//                            self.postListVM.getAllPosts(userAuthVM: userAuthVM)
//                        }, label: {
//                            Text("Expertise")
//                        })
//                        Button(action: {
//                            self.postListVM.postFilter = PostFilter.None
//                            self.postListVM.getAllPosts(userAuthVM: userAuthVM)
//                        }, label: {
//                            Text("None")
//                        })
//                    }, label: {
//                        Text("Filter")
//                        Image(systemName: "line.horizontal.3").font(Font.system(.title).bold())
//                            
//                    })
//                    
                }.modifier(MultiLineTextFieldAuthorization())
                    .padding(10)
                    Divider()
            }
            HStack {
                Text("Posts:").font(Font.headline).padding(.top, 10)
                Spacer()
                Menu(content: {
                    Button(action: {
                        self.postListVM.postFilter = PostFilter.Reagents
                        self.postListVM.getAllPosts(userAuthVM: userAuthVM)
                    }, label: {
                        Text("Reagents")
                    })
                    Button(action: {
                        self.postListVM.postFilter = PostFilter.Equipment
                        self.postListVM.getAllPosts(userAuthVM: userAuthVM)
                    }, label: {
                        Text("Equipment")
                    })
                    Button(action: {
                        self.postListVM.postFilter = PostFilter.Expertise
                        self.postListVM.getAllPosts(userAuthVM: userAuthVM)
                    }, label: {
                        Text("Expertise")
                    })
                    Button(action: {
                        self.postListVM.postFilter = PostFilter.None
                        self.postListVM.getAllPosts(userAuthVM: userAuthVM)
                    }, label: {
                        Text("None")
                    })
                }, label: {
                    Text("Filter")
                    Image(systemName: "line.horizontal.3").font(Font.system(.title).bold())
                        
                })
            }.padding(.leading)
            .padding(.trailing)
            ForEach(self.postListVM.posts, id: \.post.id) {
                postVM in
                PostRowView(postVM: postVM)
                        
                
            }
        }.padding()
        .onAppear(perform: self.postListVM.getAllPostsClosure(userAuthVM: userAuthVM))
            
    }
}

struct PostListView_Previews: PreviewProvider {
//    static let  userAuthVM: UserAuthenticationViewModel = UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true)
    static var previews: some View {
        Group {
            VStack {
                NavigationView {
                    ScrollView {
                        PostListView(postListVM: PostListViewModel(userId: 80, postListType: PostListType.Profile)).environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
                    }
                    
                }
            }
            
        }
        
        
    }
}
