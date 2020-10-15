//
//  ApproveUserWebService.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 15/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation

class ApproveUserWebService: WebService {
    
    init(userAuth: UserAuthenticationModel) {
        super.init(userAuthModel: userAuth)
    }
    func generateURLString() -> String {
        let urlString = "\(hostUrlString)/admin/non-active"
        return urlString
    }
    
    func getAllNonActiveUsers(completionFailure: @escaping () -> (), completionSuccessful: @escaping ([UserModel]?) -> ()) {

        let urlString = generateURLString()
        super.getAll(urlString: urlString, completionFailure: completionFailure, completionSuccessful: completionSuccessful)
    }
    
}
