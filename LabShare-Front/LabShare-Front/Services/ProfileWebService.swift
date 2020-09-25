//
//  UserWebservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
class ProfileWebService: WebService {
    private static var loggedInUserId: Int = -1
    private static var token: String = ""
    
    class func setLoggedInUserId(id: Int) {
        Self.loggedInUserId = id
    }
    class func setToken(token: String) {
        Self.token = token
    }
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
    
    func generateURLString(userId: Int) -> String {
        return "http://127.0.0.1:8000/users/\(userId)/profile"
    }
    
    func getProfile(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (ProfileModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func updateProfile(profileModel: ProfileModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (ProfileModel?) -> ()) {
        
        let urlString = generateURLString(userId: profileModel.owner.id)
        
        super.update(urlString: urlString, model: profileModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
        
    }
}


