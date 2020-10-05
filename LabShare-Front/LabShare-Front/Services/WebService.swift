//
//  WebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 24/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
var hostUrlString = "http://127.0.0.1:8000"
//var hostUrlString = "http://2a12b73f31b3.ngrok.io"
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
        
        generalApiMethodHelper(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.GET)
    }
    
    func post<T:Codable>(urlString: String, model: T, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
        
        generalApiMethodHelper(urlString: urlString, model: model, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.POST)
    }
    
    func update<T:Codable> (urlString: String, model: T, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
        
        generalApiMethodHelper(urlString: urlString, model: model, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.PUT)
        
    }

    func delete<T:Codable> (urlString: String, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {

        generalApiMethodHelper(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.DELETE)
    }
    
    private func generalApiMethodHelper<T:Codable> (urlString: String, model: T? = nil, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> (), apiMethod: ApiMethod) {
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
            let encoder = JSONEncoder()
            encoder.dateEncodingStrategy = .iso8601
            guard let modelData = try? encoder.encode(model) else {
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
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
//            print(T.self)
            if let model = try? decoder.decode(T.self, from: data) { //Should remove later
                DispatchQueue.main.async {
                    //Update our UI
                    
                    completionSuccessful(model)
                    return
                }
            }
//            else {
//
//            }
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
                    print("Failed to fetch data \(error.debugDescription)")
                    completionFailure()
                    
                    return
                }
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            print(T.self)
            if let modelArray = try? decoder.decode([T].self, from: data) {
                //                    We have good data - go back to the main thread
                DispatchQueue.main.async {
                    //Update our UI
                    completionSuccessful(modelArray)
                    return
                }
            }
        }.resume()
    }
}

enum ApiMethod {
    case GET, PUT, POST, DELETE, GETALL
}




//private func loginRegisterHelper<T:Codable, V:Codable> (urlString: String, modelEncode: T, modelDecode: V, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> (), apiMethod: ApiMethod) {
//
//    guard let url = URL(string: urlString) else {
//        completionFailure()
//        print("Invalid URL")
//        return
//    }
//    var request  = URLRequest(url: url)
//    request.httpMethod = "POST"
//    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//    request.setValue("Token \(self.token)", forHTTPHeaderField: "Authorization")
//
//
//    guard let requestData = try? JSONEncoder().encode(modelEncode) else {
//        print("Error Encoding")
//        completionFailure()
//        return
//    }
//    request.httpBody = requestData
//
//    URLSession.shared.dataTask(with: request) { (data, response, error) in
//        //Check for error
//        guard let responseData = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), error == nil else {
//            DispatchQueue.main.async{
//                completionFailure()
//                print("Error took place \(error.debugDescription)")
//                return
//            }
//            return
//        }
//
//        let responseModel = try? JSONDecoder().decode(V.self, from: responseData)
//        do {
//            let decoder = JSONDecoder()
//            let response = try decoder.decode(RegistrationResponse.self, from: data)
//            switch response {
//                case .success(let userModel):
//                    DispatchQueue.main.async {
//                        registerVM.attemptingRegistration = false
//                        registerVM.registrationFailed = false
//                        let userLoginModel = UserLoginModel(email: userModel.email, password: registerVM.repeatPassword)
//                        self.loginFromRegistration(user: userLoginModel, completion: completion)
//                        //Update our UI
//                        //Call Login
//
//                        return
//                    }
//                case .failure(let registrationError):
//                    DispatchQueue.main.async {
//                        //Update our UI
//                        if let emailError = registrationError.email {
//                            registerVM.emailError = emailError[0]
//                        }
//                        if let passwordError = registrationError.password {
//                            registerVM.passwordError = passwordError[0]
//                        }
//                        registerVM.attemptingRegistration = false
//                        registerVM.registrationFailed = true
//                        registerVM.repeatPassword = ""
//                        registerVM.userRegister.password = ""
//                        return
//                    }
//            }
//        } catch {
//            print("Error took place \(error)")
//        }
//    }.resume()
//
//
//func postReturnDifferentModel<T:Codable, V:Codable>(urlString: String, modelEncode: T, modelDecode: V, completionFailure: @escaping()->(), completionSuccessful: @escaping (T?) -> ()) {
//    
//    apiMethodHelper(urlString: urlString, model: model, completionFailure: completionFailure, completionSuccessful: completionSuccessful, apiMethod: ApiMethod.POST)
//}
//
//}

