//
//  PostHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostHeaderView: View {
    var post: PostModel //Probs needs to change
    
    var body: some View {
        HStack() {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            VStack (alignment: .leading) {
                Text(String(self.post.author.email))
                    .font(Font.subheadline)
                    .fontWeight(.bold)
                Text(self.post.dateCreated).font(Font.footnote).fontWeight(.thin)
            }
            Spacer()
        }
    }
}

struct PostHeader_Previews: PreviewProvider {
    static var previews: some View {
        PostHeaderView(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis")))
    }
}
