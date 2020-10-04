//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct CommentEditView: View {
    @ObservedObject var commentVM: CommentViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State var showingAlert: Bool = false
    @Binding var showSelf: Bool
    
    init (userId: Int, postId: Int, commentId: Int, showSelf: Binding<Bool>) {
        self.commentVM = CommentViewModel(userId: userId, postId: postId, commentId: commentId)
        self._showSelf = showSelf
    }
    
    init (commentVM: CommentViewModel, showSelf: Binding<Bool>) {
        self.commentVM = commentVM
        self._showSelf = showSelf
    }
    
    //    @ViewBuilder
    var body: some View {
        VStack (alignment:.center) {
//            PostHeaderView(p
            ScrollView {
                VStack (alignment: .leading){
                    Text("Comment:")
                        .font(.title)
                    ZStack {
                        TextEditor(text: self.$commentVM.commentModel.content)
                        Text(self.commentVM.commentModel.content).opacity(0).padding(.top, 12).modifier(MultiLineTextFieldAuthorization())
                    }
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.bold)
                }.padding()
                
                Button(action: {
                    self.commentVM.updateComment(userAuthVM: self.userAuthVM)
                    self.showSelf = false
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
                    .padding(.top)
            }
            
//            HStack {
//                Button(action: {
//                    self.showingAlert = true
//                }){
//                    Text("Cancel")
//                }.alert(isPresented:$showingAlert) {
//                    Alert(title: Text("Are you sure you want to cancel"), message: Text("All edits will be lost"), primaryButton: .destructive(Text("Continue")) {
//                    }, secondaryButton: .cancel())
//                }
//
//                Spacer()
//                Button(action: {
//                }){
//                    Text("Save")
//                }
//            }
            
            Spacer()
        }.padding([.top, .leading, .trailing])
//        .onAppear(perform: self.commentVM.getCommentClosure(userAuthVM: userAuthVM))
        
    }
}


struct CommentEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CommentEditView(userId: 37, postId: 27, commentId: 20, showSelf: .constant(true))
                .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
        }
        
    }
}


//                    .foregroundColor(.black)
//                        .sheet(isPresented: $isEdit) {
//                            PostEditView(postVM: PostViewModel(post: self.postVM.post), oldpostVM: self.postVM, isPresented: self.$isEdit)
//                    }
//                    Button(action: {
//                        self.showingAlert = true
//
//                    }){
//                        Image(systemName: "trash")
//                            .imageScale(.large)
//                        Text("Delete Post")
//
//                    }.foregroundColor(.black)
//                        .padding(.top, 10)
//                        .alert(isPresented:$showingAlert) {
//                            Alert(title: Text("Are you sure you want to delete this post?"), primaryButton: .destructive(Text("Delete")) {
//                                    // Actions
//                            }, secondaryButton: .cancel())
//                        }
//                }
