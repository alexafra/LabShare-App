//
//  UserWebservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
class UserWebservice {
    private static var loggedInUserId: Int = -1
    private static var token: String = ""
    
    func setLoggedInUserId(id: Int) {
        Self.loggedInUserId = id
    }
    func setToken(token: String) {
        Self.token = token
    }
    
    func getProfile(userId: Int, completion: @escaping (ProfileModel?) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/\(String(userId))/profile") else {
            print("Invalid URL")
            return
        }
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(Self.token)", forHTTPHeaderField: "Authorization")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let data = data {
                if let user = try? JSONDecoder().decode(ProfileModel.self, from: data) {
                    //                    We have good data - go back to the main thread
                    DispatchQueue.main.async {
                        //Update our UI
                        completion(user)
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


