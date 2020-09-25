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
    
    func get<T:Codable>(urlString: String, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
        
        apiMethodHelper(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.GET)
    }
    
    func post<T:Codable>(urlString: String, model: T, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
        
        apiMethodHelper(urlString: urlString, model: model, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.POST)
    }
    
    func update<T:Codable> (urlString: String, model: T, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
        
        apiMethodHelper(urlString: urlString, model: model, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.PUT)
        
    }

    func delete<T:Codable> (urlString: String, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {

        apiMethodHelper(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.DELETE)
    }
    
    private func apiMethodHelper<T:Codable> (urlString: String, model: T? = nil, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> (), apiMethod: ApiMethod) {
        guard let url = URL(string: urlString) else {
            completionFailure()
            print("Invalid URL")
            return
        }
        
        var request  = URLRequest(url: url)
        if apiMethod == ApiMethod.GET {
            request.httpMethod = "GET"
        } else if apiMethod == ApiMethod.POST {
            request.httpMethod = "POST"
        } else if apiMethod == ApiMethod.PUT {
            request.httpMethod = "PUT"
        } else if apiMethod == ApiMethod.DELETE {
            request.httpMethod = "DELETE"
        }
        
        //Should only be for POST and PUT
        
       
        
        request.setValue("Token \(self.token)", forHTTPHeaderField: "Authorization")
    
        if let model = model, apiMethod == ApiMethod.POST || apiMethod == ApiMethod.PUT {
            guard let modelData = try? JSONEncoder().encode(model) else {
                print("Error Encoding")
                completionFailure()
                return
            }
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = modelData
        }
        
    
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), error == nil else {
                DispatchQueue.main.async {
                    completionFailure()
                    print("Failed to fetch data \(error.debugDescription)")
                    return
                }
                return
            }
            let model = try? JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
                //Update our UI
                
                completionSuccessful(model)
                return
            }
        }.resume()
    }
    
    func getAll<T:Codable>(urlString: String, completionFailure: @escaping()->(), completionSuccessful: @escaping ([T]?) -> ()) {
        /*
         1. Create URL we want to read
         2. Wrap URLRequest which allows us to configuew how the url should be accessed
         3. Create and start a networking task from that url request
         4. Handle the result of that networking tak
         */
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completionFailure()
            return
        }
        
        var request  = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Token \(self.token)", forHTTPHeaderField: "Authorization")
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), error == nil else {
                DispatchQueue.main.async {
                    completionFailure()
                    print("Failed to fetch data \(error.debugDescription)")
                    return
                }
                return
            }
            let modelArray = try? JSONDecoder().decode([T].self, from: data)
                //                    We have good data - go back to the main thread
            DispatchQueue.main.async {
                //Update our UI
                completionSuccessful(modelArray)
                return
            }
        }.resume()
    }
}

enum ApiMethod {
    case GET, PUT, POST, DELETE, GETALL
}

