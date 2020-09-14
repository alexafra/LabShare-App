//
//  UserProfile.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 30/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileView: View {
    
    var userId: Int
    
    @State private var user: ProfileModel = ProfileModel(id: -1, name: "")
    
    var body: some View {
        
        VStack {
            //            ScrollView {
            
            HStack {
                Spacer()
                Text(self.user.name)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.bottom)
                Spacer()
            }.padding(.top, 15)
                .padding(.bottom, -10)
            
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text("About")
                            .font(.title)
                            .fontWeight(.medium)
                        
                        Text("Email: 22499153@student.uwa.edu.au\nMobile: 0450215119\nLocation: QEII\nJoined in: 2020").font(.footnote).padding(.horizontal,5)
                        
                    }
                    Spacer()
                }
                
                HStack{
                    Text(user.name + "'s Posts")
                        .font(.title)
                        .fontWeight(.medium)
                    Spacer()
                }
            }.padding(.leading, 5)
            PostListView()
                //                    ForEach(posts, id: \.id) {
                //                        post in
                //                        NavigationLink(destination: PostDetail(post: post)) {
                //                            PostRow(post: post)
                //                        }.navigationBarTitle("User Profile", displayMode: .inline)
                //                    }
                //            }//.onAppear(perform: loadData)
                .onAppear(perform: getUser)
        }
            .navigationBarItems(trailing: SearchBarView())
    }
    
    func getUser() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/"+String(userId)+"/profile/") else {
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
                        //Everything is good, so we can exit
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






struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 1)
    }
}

