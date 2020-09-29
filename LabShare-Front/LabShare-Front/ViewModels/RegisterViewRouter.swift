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
    @Published var RegisterPage: RegisterRouterEnum
    @Published var PostPage:
    
    init () {
        RegisterPage = RegisterRouterEnum.Register
    }
//    let objectWillChange = PassthroughSubject<RegisterViewRouter,Never>()
//    
//    var currentPage: RegisterRouterEnum = RegisterRouterEnum.Register {
//        didSet {
//            objectWillChange.send(self)
//        }
//    }
}

enum RegisterRouterEnum: String {
    case Register = "Register"
    case ProfileEdit = "ProfileEdit"
    case Login = "Login"
}

enum RegisterRouterEnum: String {
    case Register = "Register"
    case ProfileEdit = "ProfileEdit"
    case Login = "Login"
}
