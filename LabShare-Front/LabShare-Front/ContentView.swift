//
//  ContentView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 28/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var posts = [Post]()
    @State private var newUserPost = ""
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Create new post")) {
                    HStack {
                        TextField("New Item", text: self.$newUserPost )
                        Button(action: {
                            self.addPost()
                        }){
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                                .imageScale(.large)
                        }
                    }
                    
                }
                Section(header: Text("Posts:")) {
                    ForEach(posts) {
                        post in
                        PostRow(userName: post.author, postTitle: post.title, postText: post.content, timeOfPost: post.date_created)
                    }
                }
            }.onAppear(perform: loadData)
            .navigationBarTitle(Text("My Posts"))
        }
    }
    func loadData() {
        /*
        1. Create URL we want to read
        2. Wrap URLRequest which allows us to configuew how the url should be accessed
        3. Create and start a networking task from that url request
        4. Handle the result of that networking tak
        */

        guard let url = URL(string: "http://127.0.0.1:8000/users/4/posts/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode([Post].self, from: data) {
//                    We have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //Update our UI
                        self.posts = decodedResponse
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
    func addPost() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/4/posts/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = PostEncodable(title: "RandomTitle", content: "Free Iphone", author: 4)
        
        if let postData = try? JSONDecoder().decode(Post.self, from: post) {
            request.httpBody = postData
        }
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Check for error
            if let error = error {
                print("Error took place \(error.localizedDescription)")
                return
            }
            //Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
//            self.loadData()
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

