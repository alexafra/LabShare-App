//
//  PostRow.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostRowView: View {
    @ObservedObject var postVM: PostViewModel
    
    var body: some View {
        VStack (alignment: .leading, spacing: 5) {
            Divider()
            PostHeaderView(postVM: self.postVM)
            Text(self.postVM.post.title)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundColor(Color.black)
                
            
            if self.postVM.post.content.count > 50 {
                Text("\(String(self.postVM.post.content.prefix(50)))...")
            } else {
                Text(self.postVM.post.content)
            }
           
        }.padding()
        
    }
}

struct PostRow_Previews: PreviewProvider {
    static var previews: some View {
        PostRowView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis")), userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true)))
    }
    
}
