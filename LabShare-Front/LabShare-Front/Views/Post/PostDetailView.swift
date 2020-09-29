//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var postVM: PostViewModel
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @State var isEdit = false
    @State var showingAlert = false
    //    @ViewBuilder
    var body: some View {
        VStack (alignment:.leading) {
            
            NavigationLink (destination: ProfileView(userId: postVM.post.author.id)) {
                PostHeaderView(postVM: self.postVM)
            }.buttonStyle(PlainButtonStyle())
                Text(self.postVM.post.title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
            Text(self.postVM.post.content)
            
            Spacer()
        }.padding([.top, .leading, .trailing])
            .navigationBarItems(trailing: Group {
                if (postVM.post.author.id == userAuthVM.userAuth.id) {
                    NavigationLink (
                        destination: PostSettingsView(postVM: self.postVM),
                        label: {
                            Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                    })
                }
            })
            .onAppear(perform: postVM.getPostClosure(userAuthVM: userAuthVM))
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", dateCreated: Date(), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
        }
        
    }
}
