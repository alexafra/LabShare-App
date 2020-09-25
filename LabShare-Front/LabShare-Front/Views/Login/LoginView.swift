//
//  LoginView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var loginVM = LoginViewModel()
    

    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn {
                ContainerView()
            } else {
                Text("Login to Lab Share")
                    .font(Font.largeTitle.weight(.bold))
                
                TextField("Enter email address", text: self.$loginVM.userLogin.email).modifier(TextFieldAuthorization())
                if (self.loginVM.userLogin.email.isEmpty) {
                    Text("Email Required").modifier(TextError())
                } else {
                    Text("a").modifier(HiddenTextError())
                }
                    
                SecureField("Enter password", text: self.$loginVM.userLogin.password).modifier(TextFieldAuthorization())
                if (self.loginVM.userLogin.password.isEmpty) {
                    Text("Password Required").modifier(TextError())
                } else {
                    Text("a").modifier(HiddenTextError())
                }
                
                if (self.loginVM.loginFailed) {
                    Text("Oops! Your email or password were incorrect.").modifier(TextError()).padding(.top, 10)
                }

                Button(action: {
                    self.loginVM.login(completion: self.loginEnvironmentObject)
                }) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
                
                Spacer()
            }
        }.padding()
    }
    func loginEnvironmentObject(userAuthModel: UserAuthenticationModel?) {
        
        if let userAuthModel = userAuthModel {
            if userAuthModel.token.isEmpty == false {
                self.userAuthVM.userAuth.id = userAuthModel.id
                self.userAuthVM.userAuth.token = userAuthModel.token
                self.userAuthVM.userAuth.isLoggedIn = true
            }
        }
        
        self.loginVM.attemptingLogin = false
        self.loginVM.loginFailed = false
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(
            UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
