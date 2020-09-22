//
//  LoginWebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class LoginWebService {
    func login (user: UserLoginModel, completion: @escaping (UserAuthenticationModel?) -> ()) {
        guard let url = URL(string: "http://127.0.0.1:8000/login") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        guard let userLoginData = try? JSONEncoder().encode(user) else {
            print("Error Encoding")
            return
        }
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        URLSession.shared.uploadTask(with: request, from: userLoginData) { (data, response, error) in
            //Check for error
            if let error = error {
                print("Error took place \(error)")
                print("Stuff")
                return
            }
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print ("Server Error: ")
                print("Stuff")
                return
            }
            guard let data = data, error == nil else {
                print("Failed to fetch data \(error.debugDescription)")
                print("Stuff")
                return
            }
            
            let userSettings = try? JSONDecoder().decode(UserAuthenticationModel.self, from: data)
            
            
            
            DispatchQueue.main.async {
                //Update our UI
                completion(userSettings)
                return
            }
        }.resume()
    }
}
