//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct PostDetailView: View {
    @ObservedObject var postVM: PostViewModel
//    @ObservedObject var commentListVM = CommentListViewModel()
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State var showingAlert = false
    @Binding var showSelf: Bool
    
    init (userId: Int, postId: Int, showSelf: Binding<Bool>) {
//        self.commentListVM = CommentListViewModel(userId: userId, postId: postId)
        self.postVM = PostViewModel(userId: userId, postId: postId)
        self._showSelf = showSelf
        
    }
    
    init (postVM: PostViewModel, showSelf: Binding<Bool>) {
        self.postVM = postVM
//        self.commentListVM = commentListVM
//        self.commentListVM = CommentListViewModel(userId: postVM.post.author.id, postId: postVM.post.id)
        self._showSelf = showSelf
    }
    //    @ViewBuilder
    var body: some View {
        ScrollView {
            
            VStack (alignment:.leading) {
                
                NavigationLink (destination: ProfileView(userId: postVM.post.author.id)) {
                    PostHeaderView(postVM: self.postVM)
                }.buttonStyle(PlainButtonStyle())
                Text(self.postVM.post.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Text(self.postVM.post.content)
                Divider()
                CommentListView(userId: self.postVM.post.author.id, postId: self.postVM.post.id, userAuthVM: self.userAuthVM)
//                CommentListView(commentListVM: self.commentListVM)
                
                Spacer()
            }.padding([.top, .leading, .trailing])
                .onAppear(perform: postVM.getPostClosure(userAuthVM: userAuthVM))
//                .onAppear(perform: commentListVM.getAllCommentsClosure(userAuthVM: userAuthVM))
                .navigationBarItems(trailing: Group {
                    if (postVM.post.author.id == userAuthVM.userAuth.id) {
                        NavigationLink (
                            destination: PostSettingsView(postVM: self.postVM, showSelf: $showSelf),
                            label: {
                                Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                        })
                    }
                })
        }
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                ScrollView {
                    PostDetailView(postVM: PostViewModel(userId: 80, postId: 99), showSelf: .constant(true))
                        .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
                }
                
                //            }
            }
            
            
            
            
            
//            NavigationView {
//                PostDetailView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", dateCreated: Date(), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))), showSelf: Binding.constant(true))
//                    .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
//            }
        }
    
        
    }
}
