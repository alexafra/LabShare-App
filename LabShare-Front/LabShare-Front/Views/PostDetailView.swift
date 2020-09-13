//
//  PostDetail.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 29/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct PostDetailView: View {
    var post: PostModel
    @State private var user: ProfileModel = ProfileModel(id: 1, name: "Liam")
    
    @ViewBuilder
    var body: some View {
            VStack (alignment:.leading) {
                
                PostHeaderView(post: post)
                
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
                
                
                VStack(alignment: .leading) {
                    Text("User Details:").font(.subheadline).fontWeight(.medium).foregroundColor(Color.black)
                    Text(user.name+"\nEmail: 22499153@student.uwa.edu.au").font(.caption).foregroundColor(Color.black)
                    NavigationLink(destination: ProfileView(userId: post.author)) {Text("See more")
                        .font(.footnote)
                    }
                    }.onAppear(perform: getUser)
                .padding(.all, 7)
                    .padding(.top)
                
                Spacer()
            }.padding([.top, .leading, .trailing])

            
    }
    
    func getUser() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/"+String(post.author)+"/profile/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(ProfileModel.self, from: data) {
                    //                    We have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //Update our UI
                        self.user = decodedResponse
                        return
                    }
                } else {
                    print("Failed to decode")
                }
                
            } else {
                print("Failed to fetch data \(error.debugDescription)")
                return
            }
            
        }.resume()
    }
}

struct PostDetail_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailView(post: PostModel(id: 10, title: "Free Iphones", content: "Dave found joy in the daily routine of life. He awoke at the same time, ate the same breakfast and drove the same commute. He worked at a job that never seemed to change and he got home at 6 pm sharp every night. It was who he had been for the last ten years and he had no idea that was all about to change.", date_created: "2020-07-22 16:48:31", author: 4))
    }
}
