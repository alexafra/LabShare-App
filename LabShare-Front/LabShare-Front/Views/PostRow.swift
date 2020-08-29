//
//  PostRow.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostRow: View {
    var post: Post
    
    var body: some View {
        VStack (alignment: .leading) {
            Text(self.post.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            HStack {
                Text(String(self.post.author)).font(Font.footnote).fontWeight(.thin)
                Spacer()
                Text(self.post.date_created).font(Font.footnote).fontWeight(.thin)
            }
            if self.post.content.count > 50 {
                Text("\(String(self.post.content.prefix(50)))...")
            } else {
                Text(self.post.content)
            }
        }.padding()
            .navigationBarTitle(Text(post.title), displayMode: .inline)
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(post: Post(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones", date_created: "2020-07-22 16:48:31", author: 4))
    }
}
