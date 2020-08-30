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
                Text(self.post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Spacer()
                Button(action: {
                }){
                    Image(systemName: "pencil")
                        .imageScale(.large)
                    Text("Edit Post")
                }.foregroundColor(.black)
            }
            
            Text("Date Posted: " + self.post.date_created.description).font(Font.footnote).fontWeight(.thin)
            Text("\n" + self.post.content)
            
            ContactDetails(user: User(id: 1, name: "Liam"))
            
        }.padding()
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(post: Post(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", date_created: "2020-07-22 16:48:31", author: 4))
    }
}
