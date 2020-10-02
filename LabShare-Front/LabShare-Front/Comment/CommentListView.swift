//
//  ProfilePostsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct CommentListView: View {
    @ObservedObject var commentListVM: CommentListViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject private var keyboard = KeyboardResponder()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Create new comment").font(Font.headline)
                Spacer()
                Button(action: {
                    self.commentListVM.createComment(userAuthVM: self.userAuthVM)
                }){
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.green)
                        .font(Font.title.weight(.bold))
                }
            }
//            VStack (alignment: .leading) {
            ZStack {
                MultilineTextView(text: self.$commentListVM.newCommentContent)
                Text(self.commentListVM.newCommentContent)
                    .opacity(0)
                    .padding(.top, 12)
            }.modifier(MultiLineTextFieldAuthorization())
            .padding(10)
            Divider()
                    
//            }
            
            Text("Comments:")
                .font(Font.headline)
                .padding(.top, 10)
                
            ForEach(self.commentListVM.comments, id: \.commentModel.id) {
                commentVM in
                CommentView(commentVM: commentVM)
                Divider()
            }
        }
        .onAppear(perform: self.commentListVM.getAllCommentsClosure(userAuthVM: userAuthVM))
            
    }
}

struct CommentListView_Previews: PreviewProvider {
    static let  userAuthVM: UserAuthenticationViewModel = UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true)
    static var previews: some View {
//        Group {
//            VStack {
                NavigationView {
                    ScrollView {
                        CommentListView(commentListVM: CommentListViewModel(userId: 80, postId: 99)).environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
                    }
                    
                }
//            }
            
//        }
        
        
    }
}
