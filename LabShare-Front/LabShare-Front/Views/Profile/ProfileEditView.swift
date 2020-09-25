//
//  ProfileSetupView.swift
//  LabShare-Front
//
//  Created by Alexander Frazis on 23/9/20.
//  Copyright © 2020 CITS3200. All rights reserved.
//

import SwiftUI

struct ProfileEditView: View {
    @EnvironmentObject var userAuthVM: UserAuthenticationViewModel
    @ObservedObject var profileVM: ProfileViewModel
    var body: some View {
        VStack {
            if (profileVM.hasCompletedLoading) {
                ProfileView(userId: userAuthVM.userAuth.id, userAuthVM: userAuthVM)
            } else {
                VStack(alignment: .center, spacing: 40) {
                    Text("\(profileVM.profile.owner.firstName) \(profileVM.profile.owner.lastName)")
                        .font(.largeTitle)
                        .fontWeight(.semibold)
                    VStack(alignment: .leading) {
                        Text("dob:")
                        TextField("dob", text: self.$profileVM.profile.dob)
                            .modifier(TextFieldAuthorization())
                    }
                
                    VStack(alignment: .leading) {
                        Text("occupation:")
                        TextField("occupation", text: self.$profileVM.profile.occupation)
                            .modifier(TextFieldAuthorization())
                    }
                    VStack(alignment: .leading) {
                        Text("employer:")
                        TextField("employer", text: self.$profileVM.profile.employer).modifier(TextFieldAuthorization())
                    }
            
                    VStack(alignment: .leading) {
                        Text("bio:")
                        TextField("bio", text: self.$profileVM.profile.bio)
                            .modifier(TextFieldAuthorization())
                    }
                    Button(action: {
                    }) {
                        Text("Save")
                            .foregroundColor(Color.white)
                            .font(Font.title.weight(.bold))
                    }.modifier(AuthButton())
                    Spacer()
                }.padding()
            }
        }
    }
}

struct ProfileEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileEditView(profileVM: ProfileViewModel(userId: 10, userAuthVM: UserAuthenticationViewModel(id: 1, token: "e3ef7d0655f1698e348a81eb184156b74612ad59", isLoggedIn: true)))
    }
}
