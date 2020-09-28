//
//  PostSettingsView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostSettingsView: View {
    @State var userId: Int
    @State var postId: Int
    
    var body: some View {
        VStack {
            List {
                NavigationLink(destination: PostEditView(userId: self.userId, postId: self.postId)) {
                    HStack {
                        Image(systemName: "pencil")
                        Text("Edit Post")
                    }
                }.buttonStyle(PlainButtonStyle())
                HStack {
                    Image(systemName: "trash")
                        .imageScale(.large)
                    Text("Delete Post")
                }
            }
        }.navigationBarTitle(Text("Settings"), displayMode: .inline)
        
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

struct PostSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSettingsView(userId: 37)
    }
}
