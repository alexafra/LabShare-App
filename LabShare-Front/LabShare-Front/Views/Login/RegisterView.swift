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
    @ObservedObject var loginVM = LoginViewModel()
    

    var body: some View {
        VStack {
            if self.userAuthVM.userAuth.isLoggedIn {
                ContainerView()
            } else {
                Text("Login to Lab Share")
                    .font(Font.largeTitle.weight(.bold))
                
                TextField("Enter email address", text: self.$loginVM.userLogin.email)
                    .padding()
                    .border(Color.gray, width: 1)
                    .autocapitalization(.none)
                    
                SecureField("Enter password", text: self.$loginVM.userLogin.password)
                    .padding()
                    .border(Color.gray, width: 1)
                    .autocapitalization(.none)
                    
                    Button(action: {
                        self.loginVM.login(completion: self.updateEnvironmentObject)
                        self.loginVM.userLogin.email = ""
                        self.loginVM.userLogin.password = ""
                        
                        
                        
                        //Loop back to start view
                    }) {
                        Text("Login")
                            .foregroundColor(Color.white)
                            .font(Font.headline.weight(.bold))
                    }.padding(.vertical, 10)
                        .padding(.horizontal, 40)
                        .background(Color.green)
                        .cornerRadius(20)
                
                Spacer()
            }
        }
    }
    func updateEnvironmentObject(userAuthModel: UserAuthenticationModel?) {
        if let userAuthModel = userAuthModel {
            if userAuthModel.token.isEmpty == false {
                self.userAuthVM.userAuth.id = userAuthModel.id
                self.userAuthVM.userAuth.token = userAuthModel.token
                self.userAuthVM.userAuth.isLoggedIn = true
                PostWebservice().setLoggedInUserId(id: self.userAuthVM.userAuth.id)
                PostWebservice().setToken(token: self.userAuthVM.userAuth.token)
                UserWebservice().setLoggedInUserId(id: self.userAuthVM.userAuth.id)
                UserWebservice().setToken(token: self.userAuthVM.userAuth.token)
            }
        }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(
            UserAuthenticationViewModel(id: 10, token: "a47f3319dd15cc56dcb451dbeffa8dade3ea5587", isLoggedIn: true))
    }
}
