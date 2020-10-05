//
//  UserWebService.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 4/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class UserWebService: WebService {
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }

    func generateURLString(queryString: String? = nil, userId: Int? = nil) -> String {
        var urlString = "\(hostUrlString)/users"
        if let queryString = queryString {
            urlString = urlString + "?search=\(queryString)"
        } else if let userId = userId {
            urlString = urlString + "/\(userId)"
        }
        return urlString
    }
    
    func getUsersSearchBar(queryString: String, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([UserModel]?) -> ()) {
        
        let urlString = generateURLString(queryString: queryString)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func updateUser(userId: Int, userModel: UserModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (UserModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        super.update(urlString: urlString, model: userModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    
    
}
