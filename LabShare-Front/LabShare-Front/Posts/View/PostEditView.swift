//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct PostEditView: View {
    @ObservedObject var postVM: PostViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State var showingAlert: Bool = false
    @Binding var showSelf: Bool
    
    init (userId: Int, postId: Int, showSelf: Binding<Bool>) {
        self.postVM = PostViewModel(userId: userId, postId: postId)
        self._showSelf = showSelf
    }
    
    //    @ViewBuilder
    var body: some View {
        VStack (alignment:.center) {
//            PostHeaderView(p
            ScrollView {
                VStack (alignment: .leading) {
                    Text("Title:")
                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.bold)
                    
                    TextField("", text: self.$postVM.post.title)
//                        .font(.title)
//                        .foregroundColor(Color.black)
                        .modifier(TextFieldAuthorization())
                }.padding()
                
                VStack (alignment: .leading){
                    Text("Contents:")
                        .font(.title)
                    ZStack {
                        TextEditor(text: self.$postVM.post.content)
                        Text(self.postVM.post.content).opacity(0).padding(.top, 12).modifier(MultiLineTextFieldAuthorization())
                    }
//                        .font(.title)
//                        .foregroundColor(Color.black)
//                        .fontWeight(.bold)
                }.padding()
                
                Button(action: {
                    self.postVM.updatePost(userAuthVM: self.userAuthVM)
                    self.showSelf = false
                }) {
                    Text("Save")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
                    .padding(.top)
            }
            Spacer()
        }.padding([.top, .leading, .trailing])
        .onAppear(perform: self.postVM.getPostClosure(userAuthVM: userAuthVM))
        
    }
}


struct PostEditView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostEditView(userId: 37, postId: 27, showSelf: .constant(true))
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
