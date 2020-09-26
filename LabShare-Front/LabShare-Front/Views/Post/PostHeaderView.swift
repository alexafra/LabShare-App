//
//  PostHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostHeaderView: View {
    @ObservedObject var postVM: PostViewModel //Probs needs to change
    
    var body: some View {
        HStack() {
            Image(systemName: "person")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            VStack (alignment: .leading) {
                Text("\(self.postVM.post.author.firstName) \(self.postVM.post.author.lastName)")
                    .font(Font.subheadline)
                    .fontWeight(.bold)
                Text(self.postVM.post.dateCreated).font(Font.footnote).fontWeight(.thin)
            }
//            Button(action: {postVM.d}, label: {
//                /*@START_MENU_TOKEN@*/Text("Button")/*@END_MENU_TOKEN@*/
//            })
            Spacer()
        }
    }
}

struct PostHeader_Previews: PreviewProvider {
    static var previews: some View {
        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis")), userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true)))
    }
}
