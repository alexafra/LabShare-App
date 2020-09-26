//
//  LoginView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct SetUpView: View {
    
    init() {
            //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.red]

        UINavigationBar.appearance().barTintColor = UIColor.white
        UINavigationBar.appearance().tintColor = .green
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().shadowImage = UIImage()
        
//        UITabBar.appearance().backgroundColor = UIColor.white
//        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barTintColor = UIColor.white
        
//        self.tabBar.tintColor = UIColor.whiteColor()

    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("See what people are giving away")
                    .font(Font.largeTitle.weight(.bold))
                Spacer()
                NavigationLink(destination: LoginView()) {
                    Text("Login")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                }.modifier(AuthButton())
                Spacer()
                NavigationLink(destination: RegisterView()) {
                    Text("Create account")
                        .foregroundColor(Color.white)
                        .font(Font.title.weight(.bold))
                        
                }.modifier(AuthButton())
                .navigationBarTitle("", displayMode: .inline)
                Spacer()
            }
        }
    }
}

struct SetUpView_Previews: PreviewProvider {
    static var previews: some View {
        SetUpView()
    }
}
