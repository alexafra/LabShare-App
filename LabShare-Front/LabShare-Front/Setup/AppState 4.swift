//
//  RegisterViewRouter.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 27/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

class AppState: ObservableObject {
    @Published var registerPage: RegisterRouterEnum
    @Published var deleteProfilePage: ProfileDeleteRouterEnum
    @Published var deletePostPage: PostDeleteRouterEnum
    
    init () {
        registerPage = RegisterRouterEnum.Register
        deleteProfilePage = ProfileDeleteRouterEnum.NotDeleteProfile
        deletePostPage = PostDeleteRouterEnum.NotDeletePost
        
    }
    
}

enum RegisterRouterEnum: String {
    case Register = "Register"
    case ProfileEdit = "ProfileEdit"
    case Login = "Login"
}

enum ProfileDeleteRouterEnum: String {
    case DeleteProfile = "DeleteProfile"
    case NotDeleteProfile = "NotDeleteProfile"
}

enum PostDeleteRouterEnum: String {
    case DeletePost = "DeletePost"
    case NotDeletePost = "NotDeletePost"
}



