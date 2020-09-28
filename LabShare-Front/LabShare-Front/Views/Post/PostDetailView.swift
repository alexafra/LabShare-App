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
            HStack {
                Text(self.postVM.post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Spacer()
                VStack {
                    NavigationLink (
                        destination: PostSettingsView(userId: self.postVM.post.author.id, postId: self.postVM.post.id),
                        label: {
                            Image(systemName: "line.horizontal.3").font(Font.largeTitle)
                        })
                    }

                
            }
            
            Text("Date Posted: \(self.postVM.post.dateCreated.description)")
                .font(Font.footnote).fontWeight(.thin)
            Text("\n" + self.postVM.post.content)
            
            Spacer()
        }.padding([.top, .leading, .trailing])
        .onAppear(perform: postVM.getPostClosure(userAuthVM: userAuthVM))
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PostDetailView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                .environmentObject(UserAuthenticationViewModel(id: 37, token: "14f2518e6ffc20cf52642b7c7d51b63b88fe127f", isLoggedIn: true))
        }
        
    }
}
