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
            CircleImageUpdatable(imageName: self.$postVM.post.author.imageName)
                .frame(width: 50, height: 50)
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
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date(), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-100),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-200),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-500), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1800),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-3540), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-3540),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-10800),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-82800),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                       
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-86400), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                    }
                    VStack {
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-432000),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                   
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1296999),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-1814999),category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval(-2419999), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval((-2419999 * 6)), category: CategoryEnum.Reagents,author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                        
                        PostHeaderView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", dateCreated: Date().addingTimeInterval((-2419999 * 24)), category: CategoryEnum.Reagents, author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis", imageName: "image1"))))
                    }
                }
            }
        }
        
    }
}
