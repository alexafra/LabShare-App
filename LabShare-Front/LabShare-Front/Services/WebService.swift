//
//  WebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 24/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class WebService {
    
    var loggedInUserId: Int = -1
    var token: String = ""
    
    init (userAuthModel: UserAuthenticationModel) {
        self.loggedInUserId = userAuthModel.id
        self.token = userAuthModel.token
    }
    
    convenience init () {
        self.init(userAuthModel: UserAuthenticationModel(id: -1, token: "", isLoggedIn: false))
    }
    
    func getAll<T>(userId: Int, completion: @escaping (T?) -> ()) {
        /*
         1. Create URL we want to read
         2. Wrap URLRequest which allows us to configuew how the url should be accessed
         3. Create and start a networking task from that url request
         4. Handle the result of that networking tak
         */
        
        guard let url = URL(string: "http://127.0.0.1:8000/users/\(userId)/posts") else {
            print("Invalid URL")
            return
        }
        
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(self.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, error == nil else {
                print("Failed to fetch data \(error.debugDescription)")
                completion(nil)
                return
            }
            let posts = try? JSONDecoder().decode(T.self, from: data)
                //                    We have good data - go back to the main thread
            DispatchQueue.main.async {
                //Update our UI
                completion(posts)
                return
            }
        }.resume()
        
    }
    
    func createPost (post: PostEncodable, completion: @escaping ([PostModel]?) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/posts") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let postData = try? JSONEncoder().encode(post) else {
            print("Error Encoding")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(self.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = postData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
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
            self.getProfilePosts(userId: self.loggedInUserId, completion: completion)
        }.resume()
    }
    
    
    
}
