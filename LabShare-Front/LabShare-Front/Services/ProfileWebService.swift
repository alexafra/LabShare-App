//
//  UserWebservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
class ProfileWebService {
    private static var loggedInUserId: Int = -1
    private static var token: String = ""
    
    class func setLoggedInUserId(id: Int) {
        Self.loggedInUserId = id
    }
    class func setToken(token: String) {
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
            
            guard let data = data, error == nil else {
                print("Failed to fetch data \(error.debugDescription)")
                completion(nil)
                return
            }
            
            let profile = try? JSONDecoder().decode(ProfileModel.self, from: data)
                    //                    We have good data - go back to the main thread
            DispatchQueue.main.async {
                //Update our UI
                completion(profile)
                return
            }
        }.resume()
    }
    
    func updateProfile(profileModel: ProfileModel, completion: @escaping (Bool) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/\(String(profileModel.owner.id))/profile") else {
            print("Invalid URL")
            return
        }
        guard let profileData = try? JSONEncoder().encode(profileModel) else {
            print("Error Encoding")
            return
        }
        var request  = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("Token \(Self.token)", forHTTPHeaderField: "Authorization")
        request.httpBody = profileData
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if  data == nil, error != nil {
                print("Failed to fetch data \(error.debugDescription)")
                completion(false)
                return
            }
            
            DispatchQueue.main.async {
                //Update our UI
                completion(true)
                return
            }
        }.resume()
    }


}


