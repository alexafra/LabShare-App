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

    func generateURLString(queryString: String) -> String {
        return "\(hostUrlString)/users?search=\(queryString)"
    }
    
    func getUsersSearchBar(queryString: String, completionFailure: @escaping () -> (), completionSuccessful: @escaping ([UserModel]?) -> ()) {
        
        let urlString = generateURLString(queryString: queryString)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
