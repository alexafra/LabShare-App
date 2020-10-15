//
//  ResetPasswordViewModel.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 11/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class ResetPasswordViewModel: ObservableObject {
    @Published var resetPassword: ResetPasswordModel
    @Published var attemptingReset: Bool
    @Published var resetFailed: Bool
    
    init () {
        self.resetPassword = ResetPasswordModel(email: "")
        self.attemptingReset = false
        self.resetFailed = false
    }
    
    func reset() {
        if !self.resetPassword.email.isEmpty {
            self.attemptingReset = true
            ResetPasswordRegisterWebService().reset(resetP: self.resetPassword,
                completionFailure: { () -> Void in
                    self.resetPassword.email = ""
                    self.attemptingReset = false
                    self.resetFailed = true
                },
                completionSuccessful: { () in
                    self.resetPassword.email = ""
                    self.attemptingReset = false
                    self.resetFailed = false
                }
            )
    }
}
}

