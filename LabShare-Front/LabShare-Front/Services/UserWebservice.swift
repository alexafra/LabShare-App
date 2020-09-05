//
//  UserWebservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
class UserWebservice {
    func getUser(userId: Int, completion: @escaping (UserProfileModel?) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/users/\(String(userId))/profile/") else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let user = try? JSONDecoder().decode(UserProfileModel.self, from: data) {
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


