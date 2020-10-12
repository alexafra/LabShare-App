//
//  ResetPassword.swift
//  LabShare-Front
//
//  Created by Ananda Buckley on 11/10/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ResetPassword: View {
    @ObservedObject var resetVM: ResetPasswordViewModel
    @State private var showingPopUp = false
    
    init () {
        resetVM = ResetPasswordViewModel()
    }
    
    var body: some View {
        VStack {
            Text("Forgot Password?")
                .font(Font.largeTitle.weight(.bold))
                .foregroundColor(.green)
                .padding()
            
            Text("Enter your email address and follow the instructions sent to your email to reset your password.")
                .font(.callout)
                .foregroundColor(.green)
                .multilineTextAlignment(.leading)
            
            
            TextField("Enter email address", text: self.$resetVM.resetPassword.email).modifier(TextFieldAuthorization())
                .padding()
            
            Button(action: {
                if (!resetVM.resetPassword.email.isEmpty) {
                    self.resetVM.reset()
                    self.showingPopUp = true
                }
            }) {
                Text("Reset Password")
                    .foregroundColor(Color.white)
                    .font(Font.title.weight(.bold))
            }.modifier(AuthButton())
            .alert(isPresented: $showingPopUp, content: {
                Alert(title: Text("Reset Password"), message: Text("If this email is associated with a LabShare account you will recieve and email shortly."), dismissButton: .default(Text("Okay")))
            })
            Spacer()
        }.padding()
    }
}

struct ResetPassword_Previews: PreviewProvider {
    static var previews: some View {
        ResetPassword()
    }
}
