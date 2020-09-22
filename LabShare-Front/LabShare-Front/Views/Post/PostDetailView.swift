//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    @ObservedObject var postVM: PostViewModel
    @ViewBuilder
    var body: some View {
        VStack (alignment:.leading) {

            NavigationLink (destination: ProfileView(userId: postVM.post.author.id)){
                PostHeaderView(postVM: self.postVM)
            }.buttonStyle(PlainButtonStyle())
            HStack {
                Text(self.postVM.post.title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                Spacer()
                VStack {
                    Button(action: {
                    }){
                        Image(systemName: "pencil")
                            .imageScale(.large)
                        Text("Edit Post")
                    }.foregroundColor(.black)

                    Button(action: {

                    }){
                    Image(systemName: "trash")
                        .imageScale(.large)
                    Text("Delete Post")

                    }.foregroundColor(.black)
                        .padding(.top, 10)
                }

            }

            Text("Date Posted: \(self.postVM.post.dateCreated.description)")
                .font(Font.footnote).fontWeight(.thin)
            Text("\n" + self.postVM.post.content)


            VStack(alignment: .leading) {
                Text("User Details:").font(.subheadline).fontWeight(.medium).foregroundColor(Color.black)
                Text("Name: \(self.postVM.post.author.firstName) \(self.postVM.post.author.lastName)")
                    .font(.caption).foregroundColor(Color.black)
                Text("Email: \(self.postVM.post.author.email)")
                    .font(.caption).foregroundColor(Color.black)
                NavigationLink(destination: ProfileView(userId: self.postVM.post.author.id)) {Text("See more")
                    .font(.footnote)
                }
                }.onAppear(perform: getUser)
            .padding(.all, 7)
                .padding(.top)

            Spacer()
        }.padding([.top, .leading, .trailing])
    }

    func getUser() {
//        guard let url = URL(string: "http://127.0.0.1:8000/users/"+String(post.author.id)+"/profile/") else {
//            print("Invalid URL")
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let data = data {
//                if let decodedResponse = try? JSONDecoder().decode(ProfileModel.self, from: data) {
//                    //                    We have good data - go back to the main thread
//                    DispatchQueue.main.async {
//                        //Update our UI
//                        self.user = decodedResponse
//                        return
//                    }
//                } else {
//                    print("Failed to decode")
//                }
//
//            } else {
//                print("Failed to fetch data \(error.debugDescription)")
//                return
//            }
//
//        }.resume()
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(postVM: PostViewModel(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", dateCreated: "2020-07-22 16:48:31", author: UserModel (id: 7, email: "alexanderfrazis@gmail.com", firstName: "Alexander", lastName: "Frazis"))))
    }
}
