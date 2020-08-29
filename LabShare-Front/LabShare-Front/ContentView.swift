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
    @State private var newPostTitle = ""
    @State private var newPostContent = ""
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Create new post")) {
                    HStack {
                        VStack {
                            TextField("Title", text: self.$newPostTitle)
                            TextField("Content", text: self.$newPostContent)
                        }
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
                    ForEach(posts, id: \.id) {
                        post in
                        PostRow(userName: post.author, postTitle: post.title, postContent: post.content, timeOfPost: post.date_created)
                    }.onDelete(perform: delete)
                }
            }.onAppear(perform: loadData)
            .navigationBarTitle(Text("My Posts"))
        }
    }
    func delete(indexSet: IndexSet) {
        let deleteItem = self.posts[indexSet.first!]
        let deleteId = deleteItem.id
//        self.$posts.remove(indexSet.first!)
        
        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(deleteId)/") else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            //Check for error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print ("Server Error: ")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print("got data: \(dataString)")
            }
            self.loadData()
        }.resume()
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
                        for index in 0..<self.posts.count {
                            self.posts[index].content = self.posts[index].content.trimmingCharacters(in: .whitespacesAndNewlines)
                            self.posts[index].title = self.posts[index].title.trimmingCharacters(in: .whitespacesAndNewlines)
                        }
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
        self.newPostContent = self.newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
        self.newPostTitle = self.newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if self.newPostContent.isEmpty || self.newPostTitle.isEmpty {
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/posts/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = PostEncodable(title: self.newPostTitle, content: self.newPostContent, author: 4)
        
        guard let postData = try? JSONEncoder().encode(post) else {
            print("Error Encoding")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.uploadTask(with: request, from: postData) { (data, response, error) in
            //Check for error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print ("Server Error: ")
                return
            }
            if let mimeType = response.mimeType,
                mimeType == "application/json",
                let data = data,
                let dataString = String(data: data, encoding: .utf8) {
                print("got data: \(dataString)")
            }
            self.loadData()
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

