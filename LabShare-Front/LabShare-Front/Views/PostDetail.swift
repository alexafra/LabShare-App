//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostDetail: View {
    var userName: Int
    var postTitle: String
    var postContent: String
    var timeOfPost: String
    
    @ViewBuilder
    var body: some View {
        VStack (alignment: .leading) {
            Text(postTitle)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
            HStack {
                Text(String(userName)).font(Font.footnote).fontWeight(.thin)
                Spacer()
                Text(timeOfPost.description).font(Font.footnote).fontWeight(.thin)
            }
            if postContent.count > 50 {
                Text("\(String(postContent.prefix(50)))...")
            } else {
                Text(postContent)
            }
            
            
        }.padding()
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetail(userName: 4, postTitle: "Free Iphones", postContent: "I would like to give away 10 iphones", timeOfPost: "2020-07-22 16:48:31")
    }
}
