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

class RegisterViewRouter: ObservableObject {
    
    let objectWillChange = PassthroughSubject<RegisterViewRouter,Never>()
    
    var currentPage: String = "Register" {
        didSet {
            objectWillChange.send(self)
        }
    }
}
