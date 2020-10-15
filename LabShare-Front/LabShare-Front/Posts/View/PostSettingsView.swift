//
//  PostSettingsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct PostSettingsView: View {
    @ObservedObject var postVM: PostViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
//    @Environment(\.managedObjectContext) var moc
//    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    @Binding var showSelf: Bool
    @State private var showEdit: Bool = false
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: PostEditView(userId: self.postVM.post.author.id, postId: self.postVM.post.id, showSelf: $showEdit), isActive: $showEdit) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Post")
                    }
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    self.showingDeleteAlert = true
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .imageScale(.large)
                        Text("Delete Post")
                        
                    }
                    
                }.alert(isPresented: $showingDeleteAlert) {
                    Alert(title: Text("Delete Post"), message: Text("Are you sure?"), primaryButton: .destructive(Text("Delete")) {
                        self.postVM.deletePost(userAuthVM: self.userAuthVM)
                        self.showSelf = false
//                        self.presentationMode.wrappedValue.dismiss()
//                        self.presentationMode.wrappedValue.dismiss()
                        }, secondaryButton: .cancel()
                    )
                }
                
            }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        }
    }
}

struct PostSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostSettingsView(postVM: PostViewModel(userId: 70, postId: 46), showSelf: Binding.constant(true))
                .environmentObject(UserAuthenticationViewModel(id: 70, token: "356a0facdfb32b8720ada293893c4dae6267d406", isLoggedIn: true, isStaff: true, isActive: true))
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



