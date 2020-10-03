//
//  PostRow.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostRowView: View {
    @ObservedObject var postVM: PostViewModel
    @ObservedObject var commentListVM: CommentListViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    
    @State private var showDetail = false
    
    var body: some View {
        NavigationLink(destination: PostDetailView(postVM: postVM, commentListVM: commentListVM, showSelf: $showDetail), isActive: $showDetail) {
            VStack (alignment: .leading, spacing: 5) {
                Divider()
                NavigationLink (destination: ProfileView(userId: postVM.post.author.id)){
                    PostHeaderView(postVM: self.postVM)
                }.buttonStyle(PlainButtonStyle())
                
                if self.postVM.post.title.count > 50 {
                    Text("\(String(self.postVM.post.title.prefix(50))) ...")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                } else {
                    Text(self.postVM.post.title)
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color.black)
                }
                
    //            Text(self.postVM.post.title)
    //                .font(.headline)
    //                .fontWeight(.bold)
    //                .foregroundColor(Color.black)
                    
                
                if self.postVM.post.content.count > 170 {
                    Text("\(String(self.postVM.post.content.prefix(170))) ...")
                } else {
                    Text(self.postVM.post.content)
                }
               
            }.padding()
        }.buttonStyle(PlainButtonStyle())
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphonlwkjeq lwkej qlwkej lqkwje qlkwej lkqwje lkqwje lkqwje lkqwj elqwkjel kqwje lqwkjelqwkje kqwkje lqkwje lkqwje lkqwje es", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date(), author: UserModel (id: 37, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))), commentListVM: CommentListViewModel(userId: 80, postId: 99)).environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
    }
    
}
