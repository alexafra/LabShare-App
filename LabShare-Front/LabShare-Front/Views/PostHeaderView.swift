//
//  PostHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostHeader: View {
    var post: Post //Probs needs to change
    
    var body: some View {
        HStack() {
            Image(systemName: "square.fill")
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.gray, lineWidth: 2))
            VStack (alignment: .leading) {
                Text(String(self.post.author))
                    .font(Font.subheadline)
                    .fontWeight(.bold)
                Text(self.post.date_created).font(Font.footnote).fontWeight(.thin)
            }
            Spacer()
        }
    }
}

struct PostHeader_Previews: PreviewProvider {
    static var previews: some View {
        PostHeader(post: Post(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", date_created: "2020-07-22 16:48:31", author: 4))
    }
}
