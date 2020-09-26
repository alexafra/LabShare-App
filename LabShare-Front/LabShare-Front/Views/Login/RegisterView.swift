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
    @ObservedObject var registerVM: RegisterViewModel
    @EnvironmentObject var pushRegisterVM: PushRegisterViewModel
    
    init(userAuthVM: UserAuthenticationViewModel) {
        self.registerVM = RegisterViewModel(userAuthVM: userAuthVM, pushRegisterVM: PushRegisterViewModel())
    }

    var body: some View {
        VStack {
            if self.pushRegisterVM.loginFailed {
                LoginView(userAuthVM: self.userAuthVM)
            } else if self.pushRegisterVM.loginSuccessful {
                ProfileEditView(profileVM: ProfileViewModel(userId: self.userAuthVM.userAuth.id, userAuthVM: self.userAuthVM))
            } else {
                VStack (alignment: .center) {
                    Text("Register to Lab Share")
                        .font(Font.title.weight(.bold))
                        .foregroundColor(.green)
                    VStack {
                        TextField("Enter email address", text: self.$registerVM.userRegisterModel.email).modifier(TextFieldAuthorization())
                            .onTapGesture {
                                self.registerVM.emailError = ""
                            }
                        
                        if (self.registerVM.registrationFailed && !self.registerVM.emailError.isEmpty) {
                            Text(self.registerVM.emailError).modifier(TextError())
                            
                        } else if (self.registerVM.userRegisterModel.email.isEmpty) {
                            Text("Email required").modifier(TextError())
                            
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                    VStack {
                        TextField("Enter first name", text: self.$registerVM.userRegisterModel.firstName).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegisterModel.firstName.isEmpty) {
                            Text("First name required").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                    
                    VStack {
                        TextField("Enter last name", text: self.$registerVM.userRegisterModel.lastName).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegisterModel.lastName.isEmpty) {
                            Text("Last name required").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                    VStack {
                        SecureField("Enter password", text: self.$registerVM.userRegisterModel.password).modifier(TextFieldAuthorization())
                            .onTapGesture {
                                self.registerVM.passwordError = ""
                            }
                        if (self.registerVM.registrationFailed && !self.registerVM.passwordError.isEmpty) {
                            Text(self.registerVM.passwordError).modifier(TextError())
                            
                        } else if (self.registerVM.userRegisterModel.password.isEmpty) {
                            Text("Password required").modifier(TextError())
                            
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                    VStack {
                        SecureField("Repeat password", text: self.$registerVM.repeatPassword).modifier(TextFieldAuthorization())
                        if (self.registerVM.userRegisterModel.password != self.registerVM.repeatPassword) {
                            Text("Passwords do not match").modifier(TextError())
                        } else {
                            Text("a").modifier(HiddenTextError())
                        }
                    }.frame(minHeight: 0, maxHeight: .infinity)
                    Button(action: {
                        self.registerVM.register()
                    }) {
                        Text("Register")
                            .foregroundColor(Color.white)
                            .font(Font.title.weight(.bold))
                    }.modifier(AuthButton())
                }.padding()
                
            }
            Spacer()
        }
    }
}




struct RegisterView_Previews: PreviewProvider {
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]

        UINavigationBar.appearance().barTintColor = UIColor.white
//        UINavigationBar.appearance().tintColor = .green
//        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        
//        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        
//        self.tabBar.tintColor = UIColor.whiteColor()

    }
    
    static var previews: some View {
        
        
//        NavigationView {
            RegisterView(userAuthVM: UserAuthenticationViewModel()).environmentObject(
                UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: false)).navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarHidden(true)
//
//        }
            
        
        
    }
}


//Text("Register")
//                                                                                                                                .font(Font.largeTitle.weight(.bold))
