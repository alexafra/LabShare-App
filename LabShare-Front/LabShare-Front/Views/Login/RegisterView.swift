//
//  LoginView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

//Successful register equals login
struct RegisterView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var registerVM = RegisterViewModel()
    

    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn {
                ProfileEditView(profileVM: ProfileViewModel(userId: self.userAuthVM.userAuth.id))
            } else {
                VStack (alignment: .center) {
                    Text("Register to Lab Share")
                        .font(Font.largeTitle.weight(.bold))
                    VStack() {
                        TextField("Enter email address", text: self.$registerVM.userRegister.email).modifier(TextFieldAuthorization())
                            .onTapGesture {
                                self.registerVM.emailError = ""
                            }
                        
                        if (self.registerVM.registrationFailed && !self.registerVM.emailError.isEmpty) {
                            Text(self.registerVM.emailError).modifier(TextError())
                            
                        } else if (self.registerVM.userRegister.email.isEmpty) {
                            Text("Email required").modifier(TextError())
                            
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                        
                            
                        TextField("Enter first name", text: self.$registerVM.userRegister.firstName).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegister.firstName.isEmpty) {
                            Text("First name required").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                            
                        TextField("Enter last name", text: self.$registerVM.userRegister.lastName).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegister.lastName.isEmpty) {
                            Text("Last name required").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                            
                        SecureField("Enter password", text: self.$registerVM.userRegister.password).modifier(TextFieldAuthorization())
                            .onTapGesture {
                                self.registerVM.passwordError = ""
                            }
                        if (self.registerVM.registrationFailed && !self.registerVM.passwordError.isEmpty) {
                            Text(self.registerVM.passwordError).modifier(TextError())
                            
                        } else if (self.registerVM.userRegister.password.isEmpty) {
                            Text("Password required").modifier(TextError())
                            
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                        
                        SecureField("Repeat password", text: self.$registerVM.repeatPassword).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegister.password != self.registerVM.repeatPassword) {
                            Text("Passwords do not match").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }
                    Button(action: {
                        self.registerVM.register(completion: self.loginEnvironmentObject)
                    }) {
                        Text("Register")
                            .foregroundColor(Color.white)
                            .font(Font.title.weight(.bold))
                    }.modifier(AuthButton())
                }.padding()
                Spacer()
            }
        }
    }
    
    func loginEnvironmentObject(userAuthModel: UserAuthenticationModel?) {
        
        if let userAuthModel = userAuthModel {
            if userAuthModel.token.isEmpty == false {
                self.userAuthVM.userAuth.id = userAuthModel.id
                self.userAuthVM.userAuth.token = userAuthModel.token
                self.userAuthVM.userAuth.isLoggedIn = true
                PostWebService.setLoggedInUserId(id: self.userAuthVM.userAuth.id)
                PostWebService.setToken(token: self.userAuthVM.userAuth.token)
                ProfileWebService.setLoggedInUserId(id: self.userAuthVM.userAuth.id)
                ProfileWebService.setToken(token: self.userAuthVM.userAuth.token)
            }
        }
        
        
    }
}

struct RegisterView_Previews: PreviewProvider {
    
    
    static var previews: some View {
        
        RegisterView().environmentObject(
            UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}


