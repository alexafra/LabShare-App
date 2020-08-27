//
//  PostRow.swift
//  LabShareFront
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostRow: View {
    var userName: String
    var postText: String
    var timeOfPost: String
    var body: some View {
        VStack {
            HStack {
                Text(userName)
                Spacer()
                Text(timeOfPost.description).font(Font.footnote)
            }
            Text(postText)
        }.padding()
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRow(userName: "Alexander Frazis", postText: "I would like to give away 10 iphones", timeOfPost: "2020-07-22 16:48:31")
    }
}
