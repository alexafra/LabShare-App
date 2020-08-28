//
//  ContentView.swift
//  LabShareFront
//
//  Created by Alexander Frazis on 27/8/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var posts = [Post]()
    var body: some View {
        List {
            ForEach(posts) {
                post in
                PostRow(userName: post.name, postTitle: post.title, postText: post.content, timeOfPost: post.date_created)
            }
        }.onAppear(perform: loadData)
    }
    func loadData() {
        guard let url = URL(string: "http://127.0.0.1:8000/users/4/posts/") else {
            print("Invalid URL")
            return
        }
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let decodedResonse = try? JSONDecoder().decode(Posts.self, from: data) {
                    //We have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //Update our UI
                        self.posts = decodedResonse.posts
                    
                        //Everything is good, so we can exit
                        return
                    }
                }
            }
            //If were still here it means there was a problem
            print("Fetch failed: \(error?.localizedDescription ?? "Unknownerror")")
            
        }.resume()
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 1. Create URL we want to read
 2. Wrap URLRequest which allows us to configuew how the url should be accessed
 3. Create and start a networking task from that url request
 4. Handle the result of that networking tak
 */
