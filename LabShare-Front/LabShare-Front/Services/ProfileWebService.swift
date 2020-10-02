//
//  UserWebservice.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 5/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation


class ProfileWebService: WebService {
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
    
    func generateURLString(userId: Int) -> String {
        return "\(hostUrlString)/users/\(userId)/profile"
    }
    func generateUserURLString(userId: Int) -> String {
        return "\(hostUrlString)/users/\(userId)"
    }
    
    func getProfile(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (ProfileModel?) -> ()) {
        
        let urlString = generateURLString(userId: userId)
        super.get(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
    func updateProfile(profileModel: ProfileModel, completionFailure: @escaping () -> (), completionSuccessful: @escaping (ProfileModel?) -> ()) {
        
        let urlString = generateURLString(userId: profileModel.owner.id)
        
        super.update(urlString: urlString, model: profileModel, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
        
    }
    
    func deleteUser(userId: Int, completionFailure: @escaping () -> (), completionSuccessful: @escaping (ProfileModel?) -> ()) {
        
        let urlString = generateUserURLString(userId: userId)
        
        super.delete(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
        
    }
}


