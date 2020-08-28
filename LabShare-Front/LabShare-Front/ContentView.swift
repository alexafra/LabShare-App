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
    var body: some View {
        List {
            ForEach(posts) {
                post in
                PostRow(userName: post.author, postTitle: post.title, postText: post.content, timeOfPost: post.date_created)
            }
        }.onAppear(perform: loadData)
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

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

