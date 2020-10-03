//
//  ProfilePostsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 22/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct CommentListView: View {
    @ObservedObject var commentListVM: CommentListViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject private var keyboard = KeyboardResponder()
    
    init (userId: Int, postId: Int, userAuthVM: UserAuthenticationViewModel) {
        self.commentListVM = CommentListViewModel(userId: userId, postId: postId)
        self.commentListVM.getAllComments(userAuthVM: userAuthVM)
//        self.commentListVM.getAllComments(userAuthVM: userAuthVM)
//        self.commentListVM.userId = userId
//        self.commentListVM.postId = postId
    }
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
//            VStack {
            VStack (alignment: .leading) {
                Text("Comment:")
//                TextField("Add Comment", text: $commentListVM.newCommentContent)
                
                ZStack {
                    MultilineTextView(text: $commentListVM.newCommentContent)
                    Text(commentListVM.newCommentContent)
                        .opacity(0)
                        .padding(.top, 12)
                }
                   
            }
                
            Divider()
//            }.modifier(MultiLineTextFieldAuthorization())
            .padding(10)
            
            Text("Comments:")
                .font(Font.headline)
                .padding(.top, 10)
                
            ForEach(self.commentListVM.comments, id: \.commentModel.id) {
                commentVM in
                CommentView(commentVM: commentVM)
                Divider()
            }
        }
        .KeyboardAwarePadding()
//        .onAppear(perform: self.commentListVM.getAllCommentsClosure(userAuthVM: userAuthVM)) //NOT WORKING DONT KNOW WHY
            
    }
}

struct CommentListView_Previews: PreviewProvider {
    static let  userAuthVM: UserAuthenticationViewModel = UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true)
    static var previews: some View {
//        Group {
//            VStack {
                NavigationView {
                    ScrollView {
//                        CommentListView(commentListVM: CommentListViewModel(userId: 80, postId: 99) )
                        CommentListView(userId: 80, postId: 99, userAuthVM: UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
                            .environmentObject(UserAuthenticationViewModel(id: 80, token: "296251f6ec81048da3c9cc8a64192f54c4507072", isLoggedIn: true))
                    }
                    
                }
//            }
            
//        }
        
        
    }
}
