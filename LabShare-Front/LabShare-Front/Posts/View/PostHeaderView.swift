//
//  PostHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

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
                Text(self.postVM.dateMessageString)
                    .font(Font.footnote).fontWeight(.thin)
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
        Group {
            VStack {
                ScrollView {
                    
                    VStack {
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date(), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-100), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-200), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-500), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1800), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-3540), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-3540), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-10800), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-82800), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                       
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-86400), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                    }
                    VStack {
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-432000), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                   
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1296999), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1814999), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-2419999), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval((-2419999 * 6)), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval((-2419999 * 24)), author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                    }
                }
            }
        }
        
    }
}
