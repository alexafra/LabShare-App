//
//  LoginView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 19/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct SetUpView: View {
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
