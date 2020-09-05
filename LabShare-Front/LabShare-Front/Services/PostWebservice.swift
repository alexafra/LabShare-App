//
//  Webservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

//Enum to create URLS

import Foundation

class PostWebservice {
    
//    func deletePost(indexSet: IndexSet, post: Post) {
//        let deleteId = post.id
//        //        self.$posts.remove(indexSet.first!)
//        
//        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(deleteId)/") else {
//            print("Invalid URL")
//            return
//        }
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "DELETE"
//        
//        URLSession.shared.dataTask(with: request) { data, response, error in
//            //Check for error
//            if let error = error {
//                print("Error took place \(error)")
//                return
//            }
//            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
//                print ("Server Error: ")
//                return
//            }
//            if let mimeType = response.mimeType,
//                mimeType == "application/json",
//                let data = data,
//                let dataString = String(data: data, encoding: .utf8) {
//                print("got data: \(dataString)")
//            }
//            self.getAllPosts()
//        }.resume()
//    }
    func getAllPosts(completion: @escaping ([Post]?) -> ()) {
        /*
         1. Create URL we want to read
         2. Wrap URLRequest which allows us to configuew how the url should be accessed
         3. Create and start a networking task from that url request
         4. Handle the result of that networking tak
         */
        
        guard let url = URL(string: "http://127.0.0.1:8000/posts/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("Failed to fetch data \(error.debugDescription)")
                completion(nil)
                return
            }
            let decodedResponse = try? JSONDecoder().decode([Post].self, from: data)
                //                    We have good data - go back to the main thread
            DispatchQueue.main.async {
                //Update our UI
                let posts = decodedResponse
                completion(posts)
                return
            }
        }.resume()
        
    }
    
    func createPost (newPostTitle: String, newPostContent: String, author: Int = 1, completion: @escaping ([Post]?) -> ()) {
        

        if newPostContent.isEmpty || newPostTitle.isEmpty {
            return
        }

        guard let url = URL(string: "http://127.0.0.1:8000/posts/") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let post = PostEncodable(title: newPostTitle, content:newPostContent, author: author)

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
            self.getAllPosts(completion: completion)
        }.resume()
    }
    
    func deletePost(itemId: Int, completion: @escaping ([Post]?) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(itemId)/") else {
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
            self.getAllPosts(completion: completion)
        }.resume()
    }
    
    func updatePost(post: Post, newPostTitle: String, newPostContent: String, completion: @escaping ([Post]?) -> ()) {
        let newPostContent = newPostContent.trimmingCharacters(in: .whitespacesAndNewlines)
        let newPostTitle = newPostTitle.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let post = PostEncodable(title: newPostTitle, content:newPostContent, author: author)
        
        guard let postData = try? JSONEncoder().encode(post) else {
            print("Error Encoding")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if newPostContent.isEmpty || newPostTitle.isEmpty {
            return
        }
        
        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(itemId)/") else {
            print("Invalid URL")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PUT"

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
            self.getAllPosts(completion: completion)
        }.resume()
    }
}
