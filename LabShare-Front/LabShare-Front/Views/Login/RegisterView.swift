//
//  LoginView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var registerVM = RegisterViewModel()
    

    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn {
                ContainerView()
            } else {
                VStack (alignment: .center ,spacing: 20) {
                    Text("Register to Lab Share")
                        .font(Font.largeTitle.weight(.bold))
//                    VStack() {
                    TextField("Enter email address", text: self.$registerVM.userRegister.email).modifier(TextFieldAuthorization())
                    if (self.registerVM.userRegister.email.isEmpty) {
                        Text("Email required").modifier(TextError())
                    }
                    
                        
                    TextField("Enter first name", text: self.$registerVM.userRegister.firstName).modifier(TextFieldAuthorization())
                    if (self.registerVM.userRegister.firstName.isEmpty) {
                        Text("First name required").modifier(TextError())
                    }
                        
                    TextField("Enter last name", text: self.$registerVM.userRegister.lastName).modifier(TextFieldAuthorization())
                    if (self.registerVM.userRegister.lastName.isEmpty) {
                        Text("Last name required").modifier(TextError())
                    }
                        
                    SecureField("Enter password", text: self.$registerVM.userRegister.password).modifier(TextFieldAuthorization())
                    if (!self.registerVM.hasAttemptedRegister) {
                        Text("Passwords do not match").modifier(TextError())
                    }
                    SecureField("Repeat password", text: self.$registerVM.repeatPassword).modifier(TextFieldAuthorization())
                    if (!self.registerVM.hasAttemptedRegister) {
                        Text("Passwords do not match").modifier(TextError())
                    }
                    
                    NavigationLink(destination: LoginView(), isActive: self.$registerVM.hasRegistered) {
                        Button(action: {
                            self.registerVM.isRegistering = true
                            self.registerVM.register(completion: self.registerUser)
                            
                            //Loop back to start view
                        }) {
                            Text("Login")
                                .foregroundColor(Color.white)
                                .font(Font.headline.weight(.bold))
                        }.padding(.vertical, 10)
                            .padding(.horizontal, 40)
                            .background(Color.green)
                            .cornerRadius(20)
                    }
                    
                    
                }.padding()
                Spacer()
            }
        }
    }
    
    func registerUser(userRegisterModel: UserRegisterModel?, hasRegistered: Bool) {
        
        self.registerVM.hasRegistered = hasRegistered
        self.registerVM.isRegistering = false
//        if let userRegisterModel = userRegisterModel {
//            self.registerVM.userRegister.email = userRegisterModel.email
//            self.registerVM.userRegister.firstName = userRegisterModel.firstName
//            self.registerVM.userRegister.lastName = userRegisterModel.email
//            self.registerVM.userRegister.email = userRegisterModel.email
//
//        }
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView().environmentObject(
            UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}


