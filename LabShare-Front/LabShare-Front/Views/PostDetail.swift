//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostDetail: View {
    var post: Post
    
    @ViewBuilder
    var body: some View {
//        VStack (alignment: .center) {
        VStack (alignment:.leading) {
            HStack {
                VStack (alignment: .leading) {
                    Text(String(self.post.author)).font(Font.footnote).fontWeight(.thin)
                    Text(self.post.date_created.description).font(Font.footnote).fontWeight(.thin)
                }
                Spacer()
                Button(action: {
                }){
                    Image(systemName: "pencil")
                        .imageScale(.large)
                    Text("Edit Post")
                }.foregroundColor(.black)
            }
            
            Text(self.post.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            
            Text(self.post.content)
            Spacer()
        }.padding()
//            .navigationBarTitle(Text(post.postTitle), displayMode: .inline)
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(post: Post(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones", date_created: "2020-07-22 16:48:31", author: 4))
    }
}
