//
//  ResetPasswordRegisterWebService.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 11/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

class ResetPasswordRegisterWebService {
    func reset (resetP: ResetPasswordModel, completionFailure: @escaping()->(), completionSuccessful: @escaping () -> ()) {
        
        guard let url = URL(string: "\(hostUrlString)/password_reset"), let resetPasswordData = try? JSONEncoder().encode(resetP)  else {
            completionFailure()
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = resetPasswordData
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            //Check for error
            guard let data = data, let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode), error == nil, let _ = try? JSONDecoder().decode(UserAuthenticationModel.self, from: data) else {
                DispatchQueue.main.async {
                    //Update our UI
                    completionFailure()
                    return
                }
                return
            }
            DispatchQueue.main.async {
                completionSuccessful()
                return
            }
        }.resume()
    }
}
