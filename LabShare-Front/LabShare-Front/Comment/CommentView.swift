//
//  PostHeaderView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI
import Combine

struct CommentRowView: View {
    @ObservedObject var commentVM: CommentViewModel //Probs needs to change
    
    var body: some View {
//        NavigationLink(destination: EmptyView()) {
        VStack(alignment: .leading) {
            NavigationLink (destination: ProfileView(userId: commentVM.commentModel.author.id)){
                CommentHeaderView(commentVM: self.commentVM)
            }.buttonStyle(PlainButtonStyle())
            Text("\(self.commentVM.commentModel.content)")
        }.padding()
//        }
    }
}

struct CommentHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            VStack {
                ScrollView {

                    VStack {
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date(), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-100), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-200), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-500), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-1800), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))


                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-3540), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-10800), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-82800), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-86400), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                    
                    }
                    VStack {
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-432000), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-1296999), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-1814999), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                       
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-2419999), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-2419999 * 6), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                        
                        CommentRowView(commentVM: CommentViewModel(commentModel: CommentModel (id: 10, dateCreated: Date().addingTimeInterval(-2419999 * 24), postId: 10, content: "I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones I would like to give away 10 iphones", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
                    }
                }
            }
        }

    }
}
