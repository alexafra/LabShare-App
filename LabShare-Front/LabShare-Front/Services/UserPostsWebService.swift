//
//  Webservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

//Enum to create URLS

import Foundation

class UserPostsWebService: WebService {
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
//    init (userAuthModel: UserAuthenticationModel) {
//        self.loggedInUserId = userAuthModel.id
//        self.token = userAuthModel.token
//    }
    func generateURLString(userId: Int, postId: Int? = nil) -> String {
        var urlString =  "http://127.0.0.1:8000/users/\(userId)/posts"
        if let postId = postId {
            urlString = urlString + String(postId)
        }
        return urlString
    }
    
    func getAllUserPosts(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([PostModel]?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func getUserPost (userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {

        let urlString = generateURLString(userId: userId, postId: postId)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func deleteUserPost (userId: Int, postId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (PostModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId, postId: postId)
        super.delete(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
//    func getFeedPosts(userId: Int, completion: @escaping ([PostModel]?) -> ()) {
//        /*
//         1. Create URL we want to read
//         2. Wrap URLRequest which allows us to configuew how the url should be accessed
//         3. Create and start a networking task from that url request
//         4. Handle the result of that networking tak
//         */
//
//        guard let url = URL(string: "http://127.0.0.1:8000/posts") else {
//            print("Invalid URL")
//            return
//        }
//
//        var request  = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.setValue("Token \(Self.token)", forHTTPHeaderField: "Authorization")
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//
//            guard let data = data, error == nil else {
//                print("Failed to fetch data \(error.debugDescription)")
//                completion(nil)
//                return
//            }
//            let posts = try? JSONDecoder().decode([PostModel].self, from: data)
//                //                    We have good data - go back to the main thread
//            DispatchQueue.main.async {
//                //Update our UI
//                completion(posts)
//                return
//            }
//        }.resume()
//
//    }
//
//    func createPost (post: PostEncodable, completion: @escaping ([PostModel]?) -> ()) {
//        guard let url = URL(string: "http://127.0.0.1:8000/posts") else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//
//        guard let postData = try? JSONEncoder().encode(post) else {
//            print("Error Encoding")
//            return
//        }
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Token \(Self.token)", forHTTPHeaderField: "Authorization")
//        request.httpBody = postData
//
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
//            self.getProfilePosts(userId: Self.loggedInUserId, completion: completion)
//        }.resume()
//    }
//
//
//
//
//
//
//
//    //POSSIBLE PROBLEMS
//    func deletePost(postId: Int, completion: @escaping ([PostModel]?) -> ()) {
//        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(postId)") else {
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
//            self.getProfilePosts(userId: Self.loggedInUserId, completion: completion)
//        }.resume()
//    }
//
//    func updatePost(postId: Int, post: PostEncodable, completion: @escaping ([PostModel]?) -> ()) {
//
//        guard let url = URL(string: "http://127.0.0.1:8000/posts/\(postId)") else {
//            print("Invalid URL")
//            return
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//
//        guard let postData = try? JSONEncoder().encode(post) else {
//            print("Error Encoding")
//            return
//        }
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpMethod = "PUT"
//
//        URLSession.shared.uploadTask(with: request, from: postData) { (data, response, error) in
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
//            self.getProfilePosts(userId: Self.loggedInUserId, completion: completion)
//        }.resume()
//    }
}
