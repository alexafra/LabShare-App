//
//  LoginRegisterWebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class LoginRegisterWebService {
    func login (user: UserLoginModel, completionFailure: @escaping()->(), completionSuccessful: @escaping (UserAuthenticationModel?) -> ()) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/login"), let userLoginData = try? JSONEncoder().encode(user)  else {
            completionFailure()
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userLoginData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Check for error
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), error == nil, let userSettings = try? JSONDecoder().decode(UserAuthenticationModel.self, from: data) else {
                DispatchQueue.main.async {
                    //Update our UI
                    completionFailure()
                    return
                }
                return
            }
            DispatchQueue.main.async {
                completionSuccessful(userSettings)
                return
            }
        }.resume()
    }
    
    //Two fail conditions - successful return from api, with error messafe
    //OR complete unsuccessful return from api and no error message
    func register (userRegisterModel: UserRegisterModel, completionFailure: @escaping(RegistrationErrorResponse?)->(), completionSuccessful: @escaping (UserModel?, UserLoginModel?) -> ()) {
        
        guard let url = URL(string: "http://127.0.0.1:8000/register"), let userRegistrationData = try? JSONEncoder().encode(userRegisterModel)  else {
            completionFailure(nil)
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = userRegistrationData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Failure mode 2
            guard let data = data, let responseModel = try? JSONDecoder().decode(RegistrationResponse.self, from: data) else {
                DispatchQueue.main.async {
                    completionFailure(nil) //failure mode 2
                    return
                }
                return
            }
            switch responseModel {
                case .success(let userModel):
                    let userLoginModel = UserLoginModel(userRegisterModel: userRegisterModel)
                    DispatchQueue.main.async { //need access to the password
                        completionSuccessful(userModel, userLoginModel)
                        return
                    }
                case .failure(let registrationError):
                    DispatchQueue.main.async {
                        completionFailure(registrationError) //failure mode 1
                        return
                    }
            }
        }.resume()
    }
}
